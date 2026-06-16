import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/planta_controller.dart';
import '../models/planta_model.dart';

class AddPlantaScreen extends StatefulWidget {
  const AddPlantaScreen({super.key});

  @override
  State<AddPlantaScreen> createState() => _AddPlantaScreenState();
}

class _AddPlantaScreenState extends State<AddPlantaScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _especieController = TextEditingController();
  final _dataController = TextEditingController();
  final _localController = TextEditingController();

  final PlantaController _controller = PlantaController();

  File? _imagemSelecionada;

  Future<void> selecionarImagem() async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagem = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
      });
    }
  }

  void salvar() async {
    if (_formKey.currentState!.validate()) {
      Planta planta = Planta(
        nome: _nomeController.text,
        especie: _especieController.text,
        dataAquisicao: _dataController.text,
        local: _localController.text,
        foto: _imagemSelecionada?.path ?? '',
      );

      bool sucesso = await _controller.salvarPlanta(planta) > 0;

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Planta cadastrada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar planta.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _especieController.dispose();
    _dataController.dispose();
    _localController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Planta'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: selecionarImagem,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _imagemSelecionada != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _imagemSelecionada!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 50),
                            SizedBox(height: 10),
                            Text('Selecionar Foto'),
                          ],
                        ),
                ),
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome da planta',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              TextFormField(
                controller: _especieController,
                decoration: InputDecoration(
                  labelText: 'Espécie',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a espécie';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              TextFormField(
                controller: _dataController,
                decoration: InputDecoration(
                  labelText: 'Data de aquisição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a data';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              TextFormField(
                controller: _localController,
                decoration: InputDecoration(
                  labelText: 'Local',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o local';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),

              ElevatedButton(
                onPressed: salvar,
                child: Text('Salvar Planta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}