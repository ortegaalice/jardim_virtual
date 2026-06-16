import '../database/db_helper.dart';
import '../models/planta_model.dart';

class PlantaController {
  Future<int> salvarPlanta(Planta planta) async {
    final db = await DBHelper.database;

    return await db.insert(
      'plantas',
      planta.toMap(),
    );
  }

  Future<List<Planta>> listarPlantas() async {
    final db = await DBHelper.database;

    final resultado = await db.query('plantas');

    return resultado.map((map) {
      return Planta.fromMap(map);
    }).toList();
  }
}
  