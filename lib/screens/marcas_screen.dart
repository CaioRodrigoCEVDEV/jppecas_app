import 'package:flutter/material.dart';
import '../models/marca.dart';
import '../services/api_service.dart';
import 'modelos_screen.dart';

class MarcasScreen extends StatefulWidget {
  const MarcasScreen({super.key});

  @override
  State<MarcasScreen> createState() => _MarcasScreenState();
}

class _MarcasScreenState extends State<MarcasScreen> {
  List<Marca> marcas = [];

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    final online = await ApiService.verificarConexao();
    if (!online) return; // simples, sem cache
    final res = await ApiService.buscarMarcas();
    setState(() => marcas = res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JP Peças')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: marcas.length,
        itemBuilder: (context, index) {
          final m = marcas[index];
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ModelosScreen(marca: m),
                ),
              );
            },
            child: Text(m.marcasdes),
          );
        },
      ),
    );
  }
}
