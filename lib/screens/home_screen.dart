import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/providers/category_providers.dart';
import 'package:productos_app/screens/products_screen.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Categorias",
            style: TextStyle(letterSpacing: 5),
          ),
        ),
        elevation: 8,
        backgroundColor: Colors.indigo,
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(categoryProvider.categories[index].nombre),
                trailing: const Icon(Icons.arrow_forward_ios_outlined,
                    color: Colors.indigo),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductsScreen(
                            idCategory:
                                categoryProvider.categories[index].idCategoria,
                          )));
                },
              ),
          itemCount: categoryProvider.categories.length,
          separatorBuilder: (_, __) => const Divider()),
    );
  }
}
