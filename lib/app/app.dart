import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = MaskedTextController(mask: '000.000.000-00');
  final _telefoneController = MaskedTextController(mask: '(00) 00000-0000');
  final _emailController = TextEditingController();
  final _cepController = MaskedTextController(mask: '00000-000');
  final _dataNascimentoController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, informe o e-mail';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Por favor, informe um e-mail válido';
    }
    return null;
  }

  String? _validateComun(String? value) {
    {
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }
      return null;
    }
  }

  bool _validateCpf(String cpf) {
    // Remove all non-digit characters
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    if (cpf.length != 11) {
      return false;
    }

    // Invalid CPF numbers
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }

    List<int> numbers = cpf.split('').map(int.parse).toList();

    // Validate first digit
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += numbers[i] * (10 - i);
    }
    int result = sum % 11;
    if (result < 2) {
      if (numbers[9] != 0) {
        return false;
      }
    } else if (numbers[9] != 11 - result) {
      return false;
    }

    // Validate second digit
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += numbers[i] * (11 - i);
    }
    result = sum % 11;
    if (result < 2) {
      if (numbers[10] != 0) {
        return false;
      }
    } else if (numbers[10] != 11 - result) {
      return false;
    }

    return true;
  }

  Future<void> _consultarCEP() async {
    final cep = _cepController.text.replaceAll(RegExp(r'\D'), '');
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        setState(() {
          _enderecoController.text = jsonBody['logradouro'];
          _bairroController.text = jsonBody['bairro'];
          _numeroController.text =
              ''; // Preencher conforme a estrutura da API ViaCep
        });
      } else {
        throw Exception('Falha ao consultar CEP');
      }
    } catch (e) {
      ('Erro ao consultar CEP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: SizedBox(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Crie sua conta',
                    style: TextStyle(color: Colors.white, fontSize: 38),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      validator: _validateComun,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, informe o cpf';
                          }
                          if (!_validateCpf(value)) {
                            return 'CPF Inválido';
                          }
                          return null;
                        },
                        controller: _cpfController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'CPF',
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: _telefoneController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Telefone',
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                        controller: _emailController,
                        validator: _validateEmail,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'e-mail',
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: _cepController,
                        onChanged: (value) {
                          if (value.length == 9) {
                            _consultarCEP();
                          }
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'CEP',
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 500,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            width: 500,
                            child: TextFormField(
                              validator: _validateComun,
                              controller: _enderecoController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'endereço',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: 100,
                            child: TextFormField(
                              validator: _validateComun,
                              controller: _bairroController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Bairro',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 50,
                            child: TextFormField(
                              validator: _validateComun,
                              controller: _numeroController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Numero',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, informe a data de nascimento';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.length > 10) {
                          return;
                        }

                        if (value.length == 2 || value.length == 5) {
                          _dataNascimentoController.text = '$value/';
                          _dataNascimentoController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset:
                                      _dataNascimentoController.text.length));
                        }
                      },
                      controller: _dataNascimentoController,
                      decoration: const InputDecoration(
                        counterText: '',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'Data de nascimento',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: TextButton(
                      style: const ButtonStyle(),
                      onPressed: () {},
                      child: const Text(
                        'Criar Conta',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
