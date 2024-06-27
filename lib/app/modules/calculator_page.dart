import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final kmLitroEtanoController = MaskedTextController(mask: '00.0');
  final precoLitroEtanoController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');
  final precoLitroGasolinaController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');
  final kmLitroGasolinaController = MaskedTextController(mask: '00.0');
  final distanciaPercorridaEtanol = MaskedTextController(mask: '0000');
  final distanciaPercorridaGasolina = MaskedTextController(mask: '0000');

  double valorGasto = 0.0;
  double litrosNecessarios = 0.0;
  double valorGastoGasolina = 0.0;
  double litrosNecessariosGasolina = 0.0;

  void calcularGastoEtanol() {
    double distancia =
        double.parse(distanciaPercorridaEtanol.text.replaceAll(',', '.'));
    double consumo =
        double.parse(kmLitroEtanoController.text.replaceAll(',', '.'));
    double precoLitro = precoLitroEtanoController.numberValue;

    setState(() {
      litrosNecessarios = distancia / consumo;
      valorGasto = litrosNecessarios * precoLitro;
    });
    mostrarAlertaValorGastoEtanol(context);
  }

  void calcularGastoGasolina() {
    double distancia =
        double.parse(distanciaPercorridaGasolina.text.replaceAll(',', '.'));
    double consumo =
        double.parse(kmLitroGasolinaController.text.replaceAll(',', '.'));
    double precoLitro = precoLitroGasolinaController.numberValue;

    setState(() {
      litrosNecessariosGasolina = distancia / consumo;
      valorGastoGasolina = litrosNecessariosGasolina * precoLitro;
    });
    mostrarAlertaValorGastoGasolina(context);
  }

  void mostrarAlertaValorGastoEtanol(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text(
              'Valor Gasto com Etanol: R\$ ${valorGasto.toStringAsFixed(2)}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void mostrarAlertaValorGastoGasolina(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text(
              'Valor Gasto com Gasolina: R\$ ${valorGastoGasolina.toStringAsFixed(2)}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 250,
                      height: 200,
                      child: Image.asset('assets/etanol.jpg'),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                              controller: kmLitroEtanoController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'KM por Litro',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                              controller: precoLitroEtanoController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Preço Litro',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                              controller: distanciaPercorridaEtanol,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Distancia a percorrer',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            width: 280,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: TextButton(
                              style: const ButtonStyle(),
                              onPressed: () {
                                calcularGastoEtanol();
                              },
                              child: const Text(
                                'Calcular',
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
                    )
                  ],
                ),
                const SizedBox(
                  width: 248,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 250,
                      height: 200,
                      child: Image.asset('assets/gasolina.jpg'),
                    ),
                    Form(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                              controller: kmLitroGasolinaController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'KM por Litro',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                              controller: precoLitroGasolinaController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Preço Litro',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                              controller: distanciaPercorridaGasolina,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Distancia a percorrer',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            width: 280,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: TextButton(
                              style: const ButtonStyle(),
                              onPressed: () {
                                calcularGastoGasolina();
                              },
                              child: const Text(
                                'Calcular',
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
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
