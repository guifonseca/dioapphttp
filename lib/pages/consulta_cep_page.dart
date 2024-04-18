import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/via_cep_model.dart';
import 'package:trilhaapp/repositories/via_cep_repository.dart';

class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  final cepController = TextEditingController(text: "");
  final ViaCepRepository viaCepRepository = ViaCepRepository();

  ViaCEPModel viaCEPModel = ViaCEPModel();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
                "Consulta CEP",
                style: TextStyle(fontSize: 22),
              ),
              TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                maxLength: 8,
                onChanged: (value) async {
                  final cep = value.trim().replaceAll(RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    setState(() {
                      loading = true;
                    });
                    viaCEPModel = await viaCepRepository.consultarCEP(cep);
                  }
                  setState(() {
                    loading = false;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Text(viaCEPModel.logradouro ?? "",
                  style: const TextStyle(fontSize: 22)),
              Text("${viaCEPModel.localidade ?? ""} - ${viaCEPModel.uf ?? ""}",
                  style: const TextStyle(fontSize: 22)),
              Visibility(
                  visible: loading, child: const CircularProgressIndicator())
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var response = await http.get(Uri.parse("https://www.google.com"));
          print(response.statusCode);
          print(response.body);
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
