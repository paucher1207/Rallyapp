import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Página Principal")),
      body: const Center(
        child: Text(
          "Bienvenido a la Rally App 🚗💨",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
