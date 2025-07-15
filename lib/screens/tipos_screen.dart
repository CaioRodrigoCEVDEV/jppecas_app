import 'package:flutter/material.dart';
import '../models/modelo.dart';
import '../models/marca.dart';
import '../models/tipo.dart';
import '../services/api_service.dart';
import 'produtos_screen.dart';

class TiposScreen extends StatefulWidget {
  final Marca marca;
  final Modelo modelo;
  const TiposScreen({super.key, required this.marca, required this.modelo});

  @override
  State<TiposScreen> createState() => _TiposScreenState();
}

class _TiposScreenState extends State<TiposScreen> {
  List<Tipo> tipos = [];

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    final res = await ApiService.buscarTipos(widget.modelo.modcod);
    setState(() => tipos = res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.modelo.moddes)),
      body: ListView.builder(
        itemCount: tipos.length,
        itemBuilder: (context, index) {
          final t = tipos[index];
          return ListTile(
            title: Text(t.tipodes),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProdutosScreen(
                    marca: widget.marca,
                    modelo: widget.modelo,
                    tipo: t,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
