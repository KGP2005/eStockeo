import 'dart:convert';
import '../AI/groq_client.dart';
import 'assistant_contract.dart';

class AssistantApi {
  final _groq =   final assistant = AssistantApi();
  final result = await assistant.getRecommendationsNoParams();
  
  if (result['success']) {
    final recommendations = result['data'];
    // Usar las recomendaciones
  }GroqClient();

  /// Envía un mensaje al asistente usando el prompt del sistema
  Future<Map<String, dynamic>> sendMessage(String userMessage) async {
    try {
      print('=== ENVIANDO MENSAJE AL ASISTENTE ===');
      print('Mensaje: $userMessage');
      
      final result = await _groq.chat(
        systemPrompt: systemPrompt,
        userPrompt: userMessage,
      );
      
      print('=== RESPUESTA API ===');
      
      if (result['success']) {
        print('Respuesta exitosa del asistente');
        
        return {
          'success': true,
          'response': result['text'],
        };
      } else {
        print('Error: ${result['error']}');
        
        return {
          'success': false,
          'error': result['error'],
        };
      }
      
    } catch (e) {
      print('=== ERROR GENERAL ===');
      print('Error: $e');
      
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Procesa una consulta de estilo y devuelve recomendaciones JSON
  Future<Map<String, dynamic>> getStyleRecommendations({
    required String prompt,
    required String catalogSummary,
  }) async {
    try {
      // Construir el mensaje completo con el catálogo
      final fullQuery = '''$prompt

Catálogo disponible:
$catalogSummary''';

      final result = await sendMessage(fullQuery);
      
      if (result['success']) {
        try {
          // Intentar parsear la respuesta como JSON
          final jsonResponse = jsonDecode(result['response']);
          return {
            'success': true,
            'recommendations': jsonResponse,
          };
        } catch (parseError) {
          print('Error parseando JSON: $parseError');
          return {
            'success': false,
            'error': 'Respuesta del asistente no es JSON válido',
            'raw_response': result['response'],
          };
        }
      } else {
        return result;
      }
      
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Genera recomendaciones sin parámetros de entrada.
  /// 
  /// Este método es útil cuando la app NO envía contexto del usuario
  /// y delega completamente al modelo la decisión de qué recomendar.
  /// 
  /// El prompt fijo asume:
  /// - Público objetivo: 18-30 años en LATAM
  /// - Ocasión: daily (casual diario)
  /// - Clima: mild (templado)
  /// - Presupuesto: 80-200 USD
  /// 
  /// Esto permite generar recomendaciones genéricas cuando no hay
  /// información del usuario disponible.
  Future<Map<String, dynamic>> getRecommendationsNoParams() async {
    const userPrompt = '''
Genera una recomendación de outfit completa para público 18-30 años en LATAM.

Asume estos valores por defecto:
- Ocasión: daily (uso casual diario)
- Clima: mild (templado)
- Presupuesto: 80-200 USD
- Estilo: casual moderno
- Colores: neutros y versátiles

Responde SOLO con el JSON del esquema indicado, sin texto adicional.
El outfit debe ser práctico, actual y accesible en Latinoamérica.
''';

    try {
      final result = await _groq.chat(
        systemPrompt: systemPrompt,
        userPrompt: userPrompt,
        maxTokens: 1000,
      );

      if (!result['success']) {
        return result;
      }

      final text = result['text'];
      final jsonStr = _extractJson(text);
      
      if (jsonStr == null) {
        return {
          'success': false,
          'error': 'No se pudo extraer JSON de la respuesta',
        };
      }

      final recommendation = jsonDecode(jsonStr);
      
      return {
        'success': true,
        'data': recommendation,
      };
    } catch (e) {
      print('=== ERROR EN getRecommendationsNoParams ===');
      print('Error: $e');
      
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Extrae el primer bloque JSON válido de un texto
  String? _extractJson(String text) {
    try {
      // Buscar el inicio y fin de un objeto JSON
      final startIndex = text.indexOf('{');
      if (startIndex == -1) return null;

      int braceCount = 0;
      int endIndex = startIndex;

      for (int i = startIndex; i < text.length; i++) {
        if (text[i] == '{') {
          braceCount++;
        } else if (text[i] == '}') {
          braceCount--;
          if (braceCount == 0) {
            endIndex = i + 1;
            break;
          }
        }
      }

      if (braceCount != 0) return null;

      return text.substring(startIndex, endIndex);
    } catch (e) {
      print('Error extrayendo JSON: $e');
      return null;
    }
  }

  /// Obtiene el historial de conversación
  List<Map<String, dynamic>> getConversationHistory() {
    return [];
  }

  /// Limpia el historial de conversación
  void clearHistory() {
    print('Historial de conversación limpiado');
  }

  /// Verifica si el servicio está disponible
  Future<bool> isServiceAvailable() async {
    try {
      // Intentar una llamada simple para verificar conectividad
      final result = await _groq.chat(
        systemPrompt: 'You are a helpful assistant.',
        userPrompt: 'test',
        maxTokens: 10,
      );
      return result['success'] == true;
    } catch (e) {
      print('Error verificando servicio: $e');
      return false;
    }
  }

  /// Obtiene la configuración actual
  Map<String, dynamic> getConfiguration() {
    return {
      'model': 'llama3-8b-8192',
      'max_tokens': 800,
      'temperature': 0.7,
      'api_key_configured': true,
    };
  }

  /// Maneja errores y proporciona respuestas de fallback
  String handleError(dynamic error) {
    if (error.toString().contains('API key')) {
      return 'Error de configuración: Clave API no válida';
    } else if (error.toString().contains('network')) {
      return 'Error de conexión: Verifique su conexión a internet';
    } else if (error.toString().contains('rate limit')) {
      return 'Límite de solicitudes excedido: Intente nuevamente más tarde';
    } else {
      return 'Error del asistente: ${error.toString()}';
    }
  }
}