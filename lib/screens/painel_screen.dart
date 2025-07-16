import 'package:flutter/material.dart';
import 'placeholder_screen.dart';

class PainelScreen extends StatelessWidget {
  const PainelScreen({super.key});

  Widget _grupo(BuildContext context, String titulo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PlaceholderScreen(title: 'Cadastrar $titulo')),
                );
              },
              child: const Text('Cadastrar'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PlaceholderScreen(title: 'Gerenciar $titulo')),
                );
              },
              child: const Text('Gerenciar'),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciamento de Produtos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _grupo(context, 'Marca'),
            _grupo(context, 'Modelo'),
            _grupo(context, 'Tipo'),
            _grupo(context, 'Produto'),
          ],
        ),
      ),
    );
  }
}
