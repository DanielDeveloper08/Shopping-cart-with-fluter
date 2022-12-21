import 'package:flutter/material.dart';
import 'package:productos_app/screens/carrito_screen.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/product_provider.dart';

class ProductsScreen extends StatefulWidget {
  int? idCategory;
  ProductsScreen({Key? key, this.idCategory}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final products = <Producto>[];
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    productsProvider.getProductos(widget.idCategory!);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),
      body: ListView.builder(
          itemCount: productsProvider.products.length,
          itemBuilder: (BuildContext context, int index) => ProductCard(
                product: productsProvider.products[index],
              )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.shopping_cart),
          onPressed: () {
            if (productsProvider.carProducts.isEmpty) {
              final snackBar = SnackBar(
                content: const Text('No hay productos en el carrito!'),
                action: SnackBarAction(
                  label: 'ok!!!',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CarritoScreen()));
            }
          }),
    );
  }
}
