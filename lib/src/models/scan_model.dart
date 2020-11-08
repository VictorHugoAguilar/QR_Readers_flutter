class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({this.id, this.tipo, this.valor}) {
    if (this.valor.contains('https://maps')) {
      this.tipo = 'geo';
    } else {
      this.tipo = 'http';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
