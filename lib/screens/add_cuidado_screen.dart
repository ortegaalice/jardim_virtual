import 'package:flutter/material.dart';

import '../controllers/cuidado_controller.dart';
import '../models/cuidado_model.dart';

class AddCuidadoScreen extends StatefulWidget {
  final int plantaId;

  const AddCuidadoScreen({
    super.key,
    required this.plantaId,
  });

  @override
  State<AddCuidadoScreen> createState() =>
      _AddCuidadoScreenState();
}

class _AddCuidadoScreenState
    extends State<AddCuidadoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _dataController = TextEditingController();
  final _observacoesController =
      TextEditingController();

  final CuidadoController _controller =
      CuidadoController();

  String _tipoSelecionado = 'Rega';

  Future<void> salvar() async {
    if (_formKey.currentState!.validate()) {
      Cuidado cuidado = Cuidado(
        plantaId: widget.plantaId,
        tipo: _tipoSelecionado,
        data: _dataController.text,
        observacoes:
            _observacoesController.text,
      );

      await _controller.salvarCuidado(
        cuidado,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Cuidado cadastrado com sucesso!',
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _dataController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adicionar Cuidado',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _tipoSelecionado,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Tipo de cuidado',
                  border:
                      OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Rega',
                    child: Text('Rega'),
                  ),
                  DropdownMenuItem(
                    value: 'Adubação',
                    child: Text('Adubação'),
                  ),
                  DropdownMenuItem(
                    value: 'Poda',
                    child: Text('Poda'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _tipoSelecionado =
                        value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller:
                    _dataController,
                decoration:
                    const InputDecoration(
                  labelText: 'Data',
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Informe a data';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller:
                    _observacoesController,
                maxLines: 3,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Observações',
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Informe as observações';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: salvar,
                child: const Text(
                  'Salvar Cuidado',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}