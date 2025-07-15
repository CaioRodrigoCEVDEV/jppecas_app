import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/produto.dart';

class ApiService {
  static Future<bool> verificarConexao() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static Future<List<Produto>> buscarProdutos() async {
    final url = Uri.parse('https://jppecashop.com.br/pros');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body);
      return jsonList.map((e) => Produto.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao buscar produtos");
    }
  }
}