import 'package:flutter/material.dart';

import 'components/form_field.dart';
import 'controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map>(
        future: controller.getData(
            linkRequest: 'https://api.hgbrasil.com/finance?key=c30e5330'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                  child: Text(
                "Carregando dados...",
                style: TextStyle(color: Colors.grey, fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  "Erro ao carregar dados...",
                  style: TextStyle(color: Colors.grey, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                controller.dolar =
                    snapshot.data!["results"]["currencies"]["USD"]["buy"];
                controller.euro =
                    snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Divider(
                        height: 60,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Icon(Icons.monetization_on_outlined,
                          size: 100.0, color: Colors.grey),
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Text(
                          "💸 Conversor de Moedas 💸",
                          style: TextStyle(color: Colors.grey, fontSize: 30),
                        ),
                      ),
                      const Divider(
                        height: 60,
                      ),
                      buildTextFormField("Reais", "R\$",
                          controller.realController, controller.realChange),
                      const Divider(
                        height: 60,
                      ),
                      buildTextFormField("Dólar", "US\$",
                          controller.dolarController, controller.dolarChange),
                      const Divider(
                        height: 60,
                      ),
                      buildTextFormField("Euro", "EUR",
                          controller.euroController, controller.euroChange),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
