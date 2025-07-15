import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/api_service.dart';
import '../models/marca.dart';
import '../models/modelo.dart';
import '../models/tipo.dart';
import '../services/cart_service.dart';
import 'carrinho_screen.dart';
import '../services/db_service.dart';

class ProdutosScreen extends StatefulWidget {
  final Marca marca;
  final Modelo modelo;
  final Tipo tipo;
  const ProdutosScreen({super.key, required this.marca, required this.modelo, required this.tipo});

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
      final apiProdutos = await ApiService.buscarProdutosFiltro(
          widget.tipo.tipocod, widget.marca.marcascod, widget.modelo.modcod);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const CarrinhoScreen()));
          setState(() {});
        },
        icon: const Icon(Icons.shopping_cart),
        label: Text(CartService.totalItens.toString()),
      ),
      appBar: AppBar(title: Text(widget.tipo.tipodes)),
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
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('R\$ ${p.provl.toStringAsFixed(2)}'),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            CartService.adicionar(p);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
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
