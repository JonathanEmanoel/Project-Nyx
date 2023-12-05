import 'package:flutter/material.dart';

class Erro extends StatelessWidget {
  const Erro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 200, 202, 203),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            SizedBox(height: 20),
            Text(
              "Ops! Algo deu errado.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Desculpe, encontramos um erro inesperado.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              },
              child: Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }
}
