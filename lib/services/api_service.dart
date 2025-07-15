import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/produto.dart';
import '../models/marca.dart';
import '../models/modelo.dart';
import '../models/tipo.dart';

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

  static Future<List<Marca>> buscarMarcas() async {
    final url = Uri.parse('https://jppecashop.com.br/marcas');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body);
      return jsonList.map((e) => Marca.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar marcas');
    }
  }

  static Future<List<Modelo>> buscarModelos(int marca) async {
    final url = Uri.parse('https://jppecashop.com.br/modelo/$marca');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body);
      return jsonList.map((e) => Modelo.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar modelos');
    }
  }

  static Future<List<Tipo>> buscarTipos(int modelo) async {
    final url = Uri.parse('https://jppecashop.com.br/tipo/$modelo');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body);
      return jsonList.map((e) => Tipo.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar tipos');
    }
  }

  static Future<List<Produto>> buscarProdutosFiltro(
      int tipo, int marca, int modelo) async {
    final url = Uri.parse(
        'https://jppecashop.com.br/pro/$tipo?marca=$marca&modelo=$modelo');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body);
      return jsonList.map((e) => Produto.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar produtos');
    }
  }
}