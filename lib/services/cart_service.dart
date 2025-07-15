import 'package:url_launcher/url_launcher.dart';
import '../models/produto.dart';
import '../models/carrinho_item.dart';

class CartService {
  static final List<CarrinhoItem> itens = [];

  static void adicionar(Produto p) {
    final item = itens.firstWhere((i) => i.produto.procod == p.procod, orElse: () => CarrinhoItem(produto: p));
    if (!itens.contains(item)) {
      itens.add(item);
    } else {
      item.quantidade++;
    }
  }

  static void incrementar(CarrinhoItem item) => item.quantidade++;

  static void decrementar(CarrinhoItem item) {
    item.quantidade--;
    if (item.quantidade <= 0) itens.remove(item);
  }

  static void remover(CarrinhoItem item) => itens.remove(item);

  static void limpar() => itens.clear();

  static int get totalItens => itens.fold(0, (t, i) => t + i.quantidade);

  static double get total => itens.fold(0, (t, i) => t + i.total);

  static Future<void> enviarPedido() async {
    if (itens.isEmpty) return;
    final buffer = StringBuffer('Pedido de Peças:\n');
    for (var i in itens) {
      buffer.writeln('- ${i.produto.prodes} x${i.quantidade}');
    }
    buffer.writeln('Total: R\$ ${total.toStringAsFixed(2)}');
    final mensagem = Uri.encodeComponent(buffer.toString());
    final uri = Uri.parse('https://api.whatsapp.com/send?phone=5561991494321&text=$mensagem');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
