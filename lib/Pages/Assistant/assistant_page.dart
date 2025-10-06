import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Services/Assistant/assistant_api.dart';

class AssistantPage extends StatefulWidget {
  const AssistantPage({Key? key}) : super(key: key);

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final TextEditingController _ctrl = TextEditingController();
  bool _loading = false;
  String _output = '';

  final String _catalogSummary = '''ARINZA-00128|blusa lino oversize|top|blanco|smart
NOMAD-00077|pantalon recto|bottom|beige|casual
SHOES-90012|mocasines|shoes|negro|smart''';

  Future<void> _handleAsk() async {
    final input = _ctrl.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _loading = true;
      _output = '';
    });

    try {
      final result = await AssistantApi().getStyleRecommendations(
        prompt: input,
        catalogSummary: _catalogSummary,
      );

      const encoder = JsonEncoder.withIndent('  ');
      final prettyJson = encoder.convert(result);

      setState(() {
        _output = prettyJson;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _output = 'Error: $e';
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistente de Moda (MVP)'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _ctrl,
                decoration: const InputDecoration(
                  hintText: 'Ej: Outfit para cena, clima frío, S/150',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _handleAsk(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading ? null : _handleAsk,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF673AB7),
                  foregroundColor: Colors.white,
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Preguntar'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: SelectableText(
                      _output.isEmpty ? 'La respuesta aparecerá aquí...' : _output,
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}