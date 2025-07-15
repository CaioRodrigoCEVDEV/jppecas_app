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

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    final online = await ApiService.verificarConexao();

    if (online) {
      final apiProdutos = await ApiService.buscarProdutos();
      await DBService.salvarProdutos(apiProdutos);
      setState(() => produtos = apiProdutos);
    } else {
      final offlineProdutos = await DBService.buscarProdutos();
      setState(() => produtos = offlineProdutos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Produtos")),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final p = produtos[index];
          return ListTile(
            title: Text(p.prodes),
            subtitle: Text("Marca: \${p.marcasdes} • Tipo: \${p.tipodes}"),
            trailing: Text("R\$ \${p.provl.toStringAsFixed(2)}"),
          );
        },
      ),
    );
  }
}