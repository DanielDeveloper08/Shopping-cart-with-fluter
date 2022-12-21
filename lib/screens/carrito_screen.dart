import 'package:flutter/material.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/product_provider.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({Key? key}) : super(key: key);

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Carrito de compras"),
        ),
        body: Container(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(productsProvider.carProducts[index].cantidad
                            .toString()),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: FadeInImage(
                            placeholder: AssetImage("assets/jar-loading.gif"),
                            image: NetworkImage(
                                "https://gestion.promo.ec/${productsProvider.carProducts[index].imagenes[0]}"),
                            fit: BoxFit.cover,
                            width: 45,
                          ),
                        ),
                        Text(productsProvider.carProducts[index].nombre),
                        Text(
                            "\$ ${double.parse(productsProvider.carProducts[index].precio) * productsProvider.carProducts[index].cantidad}"),
                        ElevatedButton(
                          child: const Icon(Icons.delete_outline,
                              color: Colors.red, size: 20),
                          onPressed: () {
                            setState(() {
                              productsProvider.deleteProduct(
                                  productsProvider.carProducts[index]);
                            });

                            if (productsProvider.carProducts.isEmpty) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                return const HomeScreen();
                              }), (Route<dynamic> route) => false);
                            }
                          },
                        ),
                      ]),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: productsProvider.carProducts.length),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            label: Row(
              children: const [
                Text("Confirmar pedido"),
                SizedBox(width: 10),
                Icon(Icons.money_off_csred_outlined,
                    color: Colors.white, size: 20)
              ],
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final user = prefs.getString('user') ?? "";

              if (user.isNotEmpty) {
                print("COMPRA EXITOSA");
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(
                        "Compra Exitosa!",
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text("OK"),
                          onPressed: () {
                            productsProvider.clearCar();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) {
                              return const HomeScreen();
                            }), (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            }));
  }
}
