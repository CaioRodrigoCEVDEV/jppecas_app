import 'package:flutter/material.dart';
import '../models/modelo.dart';
import '../models/marca.dart';
import '../services/api_service.dart';
import 'tipos_screen.dart';

class ModelosScreen extends StatefulWidget {
  final Marca marca;
  const ModelosScreen({super.key, required this.marca});

  @override
  State<ModelosScreen> createState() => _ModelosScreenState();
}

class _ModelosScreenState extends State<ModelosScreen> {
  List<Modelo> modelos = [];
  List<Modelo> filtrados = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregar();
    controller.addListener(filtrar);
  }

  void filtrar() {
    final termo = controller.text.toLowerCase();
    setState(() {
      filtrados = modelos
          .where((m) => m.moddes.toLowerCase().contains(termo))
          .toList();
    });
  }

  Future<void> carregar() async {
    final res = await ApiService.buscarModelos(widget.marca.marcascod);
    setState(() {
      modelos = res;
      filtrados = res;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lista = controller.text.isEmpty ? modelos : filtrados;
    return Scaffold(
      appBar: AppBar(title: Text(widget.marca.marcasdes)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Pesquisar modelo',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final m = lista[index];
                return ListTile(
                  title: Text(m.moddes),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TiposScreen(
                          marca: widget.marca,
                          modelo: m,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
