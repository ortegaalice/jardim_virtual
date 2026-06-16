class Cuidado {
  int? id;
  int plantaId;
  String tipo;
  String data;
  String observacoes;

  Cuidado({
    this.id,
    required this.plantaId,
    required this.tipo,
    required this.data,
    required this.observacoes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantaId': plantaId,
      'tipo': tipo,
      'data': data,
      'observacoes': observacoes,
    };
  }

  factory Cuidado.fromMap(Map<String, dynamic> map) {
    return Cuidado(
      id: map['id'],
      plantaId: map['plantaId'],
      tipo: map['tipo'],
      data: map['data'],
      observacoes: map['observacoes'],
    );
  }

  String? get tipoCuidado => null;
}