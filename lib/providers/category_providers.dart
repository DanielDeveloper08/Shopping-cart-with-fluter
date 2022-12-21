import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class CategoryProvider extends ChangeNotifier {
  List<Categoria> categories = [];

  CategoryProvider() {
    getCategories();
  }

  getCategories() async {
    var url = Uri.parse(
        "https://gestion.promo.ec/promo/categoria/ws/listar-categorias/?VHozaS85TU9uUnhTR2FpMWh0eUJCZz09=gAAAAABgAGpunQZzKslbNqIL71S6nhjanaqWYmni6w7Bv_i0nc49t4WyDc3X6fPWVYzx2Lg_3b8PabFJ5RUF2rS43OGWXQ-Yuw==");

    final response = await http.get(url);

    final categoryResponse = CategoryResponse.fromJson(response.body);

    categories = categoryResponse.resultados;

    print("CATEGORIA $categories");
    notifyListeners();
  }
}
