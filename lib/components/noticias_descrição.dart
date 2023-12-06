import 'package:flutter/material.dart';
import 'package:projeto_nyx/Models/models_news.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesNoticiaScreen extends StatelessWidget {
  final Noticia noticia;

  DetalhesNoticiaScreen({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Notícia"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              noticia.titulo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              noticia.descricao,
              style: TextStyle(fontSize: 18),
            ),
           SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _abrirLinkNoticia(noticia.link);
              },
              child: Text("Abrir Link"),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirLinkNoticia(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      // Não é possível abrir o link
      print("Erro ao abrir o link");
    }
  }
}