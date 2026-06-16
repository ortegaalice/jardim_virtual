import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jardim_virtual/models/cuidado_model.dart';
import 'package:jardim_virtual/models/planta_model.dart';
import '../controllers/cuidado_controller.dart';

class AddCuidadoScreen extends StatelessWidget {
  final int plantaId;

  const AddCuidadoScreen({
    super.key,
    required this.plantaId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Cuidado'),
      ),
      body: Center(
        child: Text(
          'Cadastrar cuidado da planta $plantaId',
        ),
      ),
    );
  }
}

class PlantaDetailScreen extends StatefulWidget {
  final Planta planta;

  const PlantaDetailScreen({
    super.key,
    required this.planta,
  });

  @override
  State<PlantaDetailScreen> createState() =>
      _PlantaDetailScreenState();
}

class _PlantaDetailScreenState
    extends State<PlantaDetailScreen> {
  final CuidadoController _controller =
      CuidadoController();

  List<Cuidado> cuidados = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarCuidados();
  }

  Future<void> carregarCuidados() async {
    final lista =
        await _controller.listarCuidados(
      widget.planta.id!,
    );

    setState(() {
      cuidados = lista;
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.planta.nome),
      ),
      body: carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  if (widget.planta.foto != null &&
                      widget.planta.foto!.isNotEmpty)
                    Center(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12),
                        child: Image.file(
                          File(widget.planta.foto!),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  Text(
                    'Nome: ${widget.planta.nome}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Espécie: ${widget.planta.especie}',
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Data de aquisição: ${widget.planta.dataAquisicao}',
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Local: ${widget.planta.local}',
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Histórico de cuidados',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: cuidados.isEmpty
                        ? const Center(
                            child: Text(
                              'Nenhum cuidado registrado.',
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                cuidados.length,
                            itemBuilder:
                                (context, index) {
                              final cuidado =
                                  cuidados[
                                      index];

                              return Card(
                                child: ListTile(
                                  leading:
                                      const Icon(
                                    Icons
                                        .local_florist,
                                  ),
                                  title: Text(
                                    'Tipo: ${cuidado.tipo}',
                                  ),
                                  subtitle:
                                      Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        'Data: ${cuidado.data}',
                                      ),
                                      Text(
                                        'Observações: ${cuidado.observacoes}',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton:
          FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddCuidadoScreen(
                plantaId:
                    widget.planta.id!,
              ),
            ),
          );

          carregarCuidados();
        },
      ),
    );
  }
}