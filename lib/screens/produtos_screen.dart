import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({super.key});

  @override
  State<ProdutosScreen> createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  List<Produto> produtos = [];
  List<Produto> filtrados = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarProdutos();
    _controller.addListener(_filtrarProdutos);
  }

  void _filtrarProdutos() {
    final termo = _controller.text.toLowerCase();
    setState(() {
      filtrados = produtos
          .where((p) => p.prodes.toLowerCase().contains(termo))
          .toList();
    });
  }

  Future<void> carregarProdutos() async {
    final online = await ApiService.verificarConexao();

    if (online) {
      final apiProdutos = await ApiService.buscarProdutos();
      await DBService.salvarProdutos(apiProdutos);
      setState(() {
        produtos = apiProdutos;
        filtrados = apiProdutos;
      });
    } else {
      final offlineProdutos = await DBService.buscarProdutos();
      setState(() {
        produtos = offlineProdutos;
        filtrados = offlineProdutos;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lista = _controller.text.isEmpty ? produtos : filtrados;
    return Scaffold(
      appBar: AppBar(title: const Text('JP Peças')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Pesquisa Geral',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final p = lista[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(p.prodes),
                    subtitle:
                        Text('Marca: ${p.marcasdes} • Tipo: ${p.tipodes}'),
                    trailing:
                        Text('R\$ ${p.provl.toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}