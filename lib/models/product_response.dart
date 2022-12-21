// To parse this JSON data, do
//
//     final categoryResponsive = categoryResponsiveFromMap(jsonString);

import 'dart:convert';

class ProductResponsive {
  ProductResponsive({
    required this.estado,
    required this.productos,
  });

  bool estado;
  List<Producto> productos;

  factory ProductResponsive.fromJson(String str) =>
      ProductResponsive.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponsive.fromMap(Map<String, dynamic> json) =>
      ProductResponsive(
        estado: json["estado"],
        productos: List<Producto>.from(
            json["productos"].map((x) => Producto.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "estado": estado,
        "productos": List<dynamic>.from(productos.map((x) => x.toMap())),
      };
}

class Producto {
  Producto(
      {required this.idProducto,
      required this.tipo,
      required this.codPrincipal,
      required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.stock,
      required this.imagenes,
      this.cantidad = 1});

  int idProducto;
  int tipo;
  int cantidad;
  int codPrincipal;
  String nombre;
  String descripcion;
  String precio;
  int stock;
  List<String> imagenes;

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        idProducto: json["id_producto"],
        tipo: json["tipo"],
        codPrincipal: json["cod_principal"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        stock: json["stock"],
        imagenes: List<String>.from(json["imagenes"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id_producto": idProducto,
        "tipo": tipo,
        "cod_principal": codPrincipal,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "stock": stock,
        "imagenes": List<dynamic>.from(imagenes.map((x) => x)),
      };
}
