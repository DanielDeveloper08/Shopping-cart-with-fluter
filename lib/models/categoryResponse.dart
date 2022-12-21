import 'dart:convert';

import 'package:productos_app/models/models.dart';

class CategoryResponse {
  CategoryResponse({
    required this.estado,
    required this.resultados,
  });

  bool estado;
  List<Categoria> resultados;

  factory CategoryResponse.fromJson(String str) =>
      CategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryResponse.fromMap(Map<String, dynamic> json) =>
      CategoryResponse(
        estado: json["estado"],
        resultados: List<Categoria>.from(
            json["lista"].map((x) => Categoria.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "estado": estado,
        "lista": List<dynamic>.from(resultados.map((x) => x.toMap())),
      };
}
