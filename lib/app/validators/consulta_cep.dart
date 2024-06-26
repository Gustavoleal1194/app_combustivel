// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

class CepConsulta {
  Future<EnderecoModel> consultarCEP(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'\D'), '');
    final url = Uri.parse('https://viacep.com.br/ws/$cleanCep/json/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        final endereco = EnderecoModel(
            logradouro: jsonBody['logradouro'], bairro: jsonBody['bairro']);
        return endereco;
      } else {
        throw Exception('Falha ao consultar CEP');
      }
    } catch (e) {
      throw Exception('Erro ao consultar CEP: $e');
    }
  }
}

class EnderecoModel {
  String logradouro;
  String bairro;
  EnderecoModel({
    required this.logradouro,
    required this.bairro,
  });
}
