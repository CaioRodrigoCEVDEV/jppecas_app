import 'package:flutter/material.dart';
import '../services/cart_service.dart';

class CarrinhoScreen extends StatefulWidget {
  const CarrinhoScreen({super.key});

  @override
  State<CarrinhoScreen> createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  void atualizar() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: CartService.itens.length,
              itemBuilder: (context, index) {
                final item = CartService.itens[index];
                return ListTile(
                  title: Text(item.produto.prodes),
                  subtitle: Text('Qtd: ${item.quantidade}'),
                  trailing: Text('R\$ ${item.total.toStringAsFixed(2)}'),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          CartService.decrementar(item);
                          atualizar();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          CartService.incrementar(item);
                          atualizar();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Total: R\$ ${CartService.total.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    await CartService.enviarPedido();
                    setState(() {});
                  },
                  child: const Text('Enviar Pedido'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
