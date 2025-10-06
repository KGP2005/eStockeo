import 'package:flutter/material.dart';
import '../registro_controller.dart';
import '../widgets/progress_indicator.dart';

class Paso2Datos extends StatelessWidget {
  final RegistroController controller;

  const Paso2Datos({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Título
            const Text(
              'Crear una cuenta',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Indicador de paso
            RegistroProgressIndicator(pasoActual: controller.pasoActual),
            
            const SizedBox(height: 32),
            
            // Nombre completo
            _buildTextField(
              controller: controller.nombreCompletoController,
              hintText: 'Nombre completo',
            ),
            
            const SizedBox(height: 16),
            
            // Fecha de Nacimiento y Género
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: controller.fechaNacimientoController,
                    hintText: 'Fecha de Nacimiento',
                    readOnly: true,
                    onTap: () => _seleccionarFecha(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return _buildDropdown(
                        value: controller.genero.isEmpty ? null : controller.genero,
                        hintText: 'Género',
                        items: ['Masculino', 'Femenino', 'Otro'],
                        onChanged: (value) {
                          if (value != null) {
                            controller.setGenero(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // País y Departamento
            Row(
              children: [
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return _buildDropdown(
                        value: controller.pais.isEmpty ? null : controller.pais,
                        hintText: 'País',
                        items: ['Perú', 'Argentina', 'Chile', 'Colombia'],
                        onChanged: (value) {
                          if (value != null) {
                            controller.setPais(value);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return _buildDropdown(
                        value: controller.departamento.isEmpty ? null : controller.departamento,
                        hintText: 'Departamento',
                        items: ['Lima', 'Arequipa', 'Cusco', 'La Libertad'],
                        onChanged: (value) {
                          if (value != null) {
                            controller.setDepartamento(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Provincia y Distrito
            Row(
              children: [
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return _buildDropdown(
                        value: controller.provincia.isEmpty ? null : controller.provincia,
                        hintText: 'Provincia',
                        items: ['Lima', 'Callao', 'Huaral', 'Cañete'],
                        onChanged: (value) {
                          if (value != null) {
                            controller.setProvincia(value);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return _buildDropdown(
                        value: controller.distrito.isEmpty ? null : controller.distrito,
                        hintText: 'Distrito',
                        items: ['Miraflores', 'San Isidro', 'Surco', 'La Molina'],
                        onChanged: (value) {
                          if (value != null) {
                            controller.setDistrito(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Celular
            _buildTextField(
              controller: controller.celularController,
              hintText: 'Celular',
              keyboardType: TextInputType.phone,
            ),
            
            const SizedBox(height: 16),
            
            // Dirección
            _buildTextField(
              controller: controller.direccionController,
              hintText: 'Dirección',
            ),
            
            const SizedBox(height: 40),
            
            // Botón Siguiente
            AnimatedBuilder(
              animation: Listenable.merge([
                controller.nombreCompletoController,
                controller.fechaNacimientoController,
                controller.celularController,
                controller.direccionController,
              ]),
              builder: (context, _) {
                final habilitado = controller.paso2Completo;
                
                return SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: habilitado
                        ? () {
                            controller.siguientePaso();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: habilitado
                          ? const Color(0xFF5D4FB5)
                          : const Color(0xFFE8E8E8),
                      disabledBackgroundColor: const Color(0xFFE8E8E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Siguiente',
                      style: TextStyle(
                        color: habilitado ? Colors.white : const Color(0xFFA0A0A0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5D4FB5),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      controller.setFechaNacimiento(picked);
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFBDBDBD),
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hintText,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hintText,
            style: const TextStyle(
              color: Color(0xFFBDBDBD),
              fontSize: 15,
            ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9E9E9E)),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
