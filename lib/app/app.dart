import 'package:app_combustivel/app/validators/consulta_cep.dart';
import 'package:app_combustivel/app/validators/input_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

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
  final CepConsulta _cepService = CepConsulta();

  void _consultarCEP(String cep) async {
    try {
      final endereco = await _cepService.consultarCEP(cep);
      _enderecoController.text = endereco.logradouro;
      _bairroController.text = endereco.bairro;

      setState(() {});
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
                      validator: InputValidator.validateComun,
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
                        if (!InputValidator.validateCpf(value)) {
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
                        validator: InputValidator.validateEmail,
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
                            _consultarCEP(value);
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
                              validator: InputValidator.validateComun,
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
                              validator: InputValidator.validateComun,
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
                              validator: InputValidator.validateComun,
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
