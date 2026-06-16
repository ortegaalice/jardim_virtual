import 'package:flutter/material.dart';

import '../controllers/planta_controller.dart';
import '../models/planta_model.dart';
import 'add_planta_screen.dart';
import 'planta_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PlantaController _controller = PlantaController();

  List<Planta> plantas = [];

  @override
  void initState() {
    super.initState();
    carregarPlantas();
  }

  Future<void> carregarPlantas() async {
    plantas = await _controller.listarPlantas();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Jardim Virtual'),
      ),

      body: plantas.isEmpty
          ? Center(
              child: Text(
                'Nenhuma planta cadastrada.',
              ),
            )

          : ListView.builder(
              itemCount: plantas.length,

              itemBuilder: (context, index) {

                final planta = plantas[index];

                return Card(
                  margin: EdgeInsets.all(8),

                  child: ListTile(

                    title: Text(planta.nome),

                    subtitle: Text(
                      planta.especie,
                    ),

                    onTap: () async {

                      await Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => PlantaDetailScreen(
                            planta: planta,
                          ),
                        ),
                      );

                      carregarPlantas();
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(

        child: Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) => AddPlantaScreen(),
            ),
          );

          carregarPlantas();
        },
      ),
    );
  }
}