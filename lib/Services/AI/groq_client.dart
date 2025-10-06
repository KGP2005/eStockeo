import 'package:dio/dio.dart';

class GroqClient {
  late final Dio _dio;
  
  GroqClient() {
    final apiKey = const String.fromEnvironment('GROQ_API_KEY');
    
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.groq.com/openai/v1',
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  /// Realiza un chat completion con Groq API
  Future<Map<String, dynamic>> chat({
    required String systemPrompt,
    required String userPrompt,
    String model = 'llama3-8b-8192',
    int maxTokens = 800,
  }) async {
    try {
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': model,
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {'role': 'user', 'content': userPrompt},
          ],
          'temperature': 0.7,
          'max_tokens': maxTokens,
        },
      );

      final content = response.data['choices'][0]['message']['content'];
      
      return {
        'success': true,
        'text': content,
      };
    } on DioException catch (e) {
      print('=== ERROR GROQ API ===');
      print('Status: ${e.response?.statusCode}');
      print('Message: ${e.message}');
      print('Response: ${e.response?.data}');
      
      return {
        'success': false,
        'error': e.response?.data['error']?['message'] ?? e.message,
      };
    } catch (e) {
      print('=== ERROR GENERAL ===');
      print('Error: $e');
      
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}
