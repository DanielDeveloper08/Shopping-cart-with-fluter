// To parse this JSON data, do
//
//     final categoryResponsive = categoryResponsiveFromMap(jsonString);

import 'dart:convert';

class Categoria {
  Categoria({
    required this.idCategoria,
    required this.nombre,
    required this.descripcion,
    required this.icono,
    required this.background,
  });

  int idCategoria;
  String nombre;
  String descripcion;
  String icono;
  String background;

  factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        idCategoria: json["id_categoria"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        icono: json["icono"],
        background: json["background"],
      );

  Map<String, dynamic> toMap() => {
        "id_categoria": idCategoria,
        "nombre": nombre,
        "descripcion": descripcion,
        "icono": icono,
        "background": background,
      };
}
