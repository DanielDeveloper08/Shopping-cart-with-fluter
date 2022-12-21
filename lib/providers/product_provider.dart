import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class ProductProvider extends ChangeNotifier {
  List<Producto> products = [];
  List<Producto> _carProducts = [];
  ProductProvider();

  getProductos(int id) async {
    var url = Uri.parse(
        'https://gestion.promo.ec/promo/productos/ws/categoria-listar-productos/?VHozaS85TU9uUnhTR2FpMWh0eUJCZz09=gAAAAABgAGpunQZzKslbNqIL71S6nhjanaqWYmni6w7Bv_i0nc49t4WyDc3X6fPWVYzx2Lg_3b8PabFJ5RUF2rS43OGWXQ-Yuw==&id_sucursal=20&id_categoria=$id&id_subcategoria=0&offset=0&limit=10');

    final response = await http.get(url);

    final productResponse = ProductResponsive.fromJson(response.body);

    products = productResponse.productos;
    print("CATEGORIA $products");
    notifyListeners();
  }

  addProductCar(Producto p) {
    bool existProduct = false;
    _carProducts.forEach((product) {
      if (p.idProducto == product.idProducto) {
        print("ENTROO");
        product.cantidad++;
        existProduct = true;
      }
    });
    if (!existProduct) {
      _carProducts.add(p);
    }
    notifyListeners();
  }

  clearCar() {
    _carProducts.clear();
    notifyListeners();
  }

  deleteProduct(Producto product) {
    print("IDDDD $product");
    if (product.cantidad > 1) {
      _carProducts.forEach((p) {
        if (p.idProducto == product.idProducto) {
          p.cantidad--;
        }
      });
    } else {
      _carProducts.remove(product);
    }
  }

  List<Producto> get carProducts => _carProducts;
}
