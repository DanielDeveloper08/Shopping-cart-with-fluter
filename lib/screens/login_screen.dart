import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String password = '', usuario = '';

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
      child: cuerpo(context),
    ));
  }

  Widget cuerpo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 230),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Center(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            nombre(),
            const SizedBox(height: 20),
            campoUsuario(),
            const SizedBox(height: 10),
            campoPassword(),
            const SizedBox(height: 30),
            buttonInicioSesion(),
          ],
        ),
      ),
    );
  }

  Widget nombre() {
    return const Text(
      "Sign in",
      style: TextStyle(
          color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget campoUsuario() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextFormField(
          validator: (valor) {
            if (valor!.isEmpty) {
              return "Correo es requerido";
            }
            return null;
          },
          onChanged: (val) {
            setState(() {
              usuario = val;
            });
          },
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "User",
            fillColor: Colors.grey,
            filled: true,
          ),
        ));
  }

  Widget campoPassword() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextFormField(
          obscureText: true,
          onChanged: (val) {
            setState(() {
              password = val;
            });
          },
          decoration: const InputDecoration(
            hintText: "Password",
            fillColor: Colors.grey,
            filled: true,
          ),
        ));
  }

  Widget buttonInicioSesion() {
    final loginProvider = Provider.of<LoginProvider>(context);
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          if (await loginProvider.signIn(usuario, password)) {
            Navigator.pushReplacementNamed(context, 'home');
          } else {
            final snackBar = SnackBar(
              content: const Text('Usuario o contrasena incorrecta!'),
              action: SnackBarAction(
                label: 'ok!!!',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        style: TextButton.styleFrom(
            backgroundColor: Colors.indigo, foregroundColor: Colors.white),
        child: const Text("Iniciar Sesion"),
      ),
    );
  }
}
