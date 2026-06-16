import '../database/db_helper.dart';
import '../models/cuidado_model.dart';

class CuidadoController {

  Future<int> salvarCuidado(Cuidado cuidado) async {
    final db = await DBHelper.database;

    return await db.insert(
      'cuidados',
      cuidado.toMap(),
    );
  }

  Future<List<Cuidado>> listarCuidados(int plantaId) async {
    final db = await DBHelper.database;

    final resultado = await db.query(
      'cuidados',
      where: 'plantaId = ?',
      whereArgs: [plantaId],
    );

    return resultado.map((map) {
      return Cuidado.fromMap(map);
    }).toList();
  }

}