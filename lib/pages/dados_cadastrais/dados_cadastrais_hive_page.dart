import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/repositories/dados_cadastrais_repository.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({super.key});

  @override
  State<DadosCadastraisHivePage> createState() =>
      _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastraisModel = DadosCadastraisModel.empty();

  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController dataNascimentoController =
      TextEditingController(text: "");
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];
  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    dadosCadastraisRepository = await DadosCadastraisRepository.carregar();
    dadosCadastraisModel = dadosCadastraisRepository.obterDados();
    nomeController.text = dadosCadastraisModel.nome ?? "";
    dataNascimentoController.text =
        (dadosCadastraisModel.dataNascimento ?? "").toString();
    setState(() {});
  }

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i < quantidadeMaxima; i++) {
      itens.add(DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus dados"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: salvando
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    const TextLabel(
                      texto: 'Nome',
                    ),
                    TextField(controller: nomeController),
                    const TextLabel(
                      texto: 'Data de nascimento',
                    ),
                    TextField(
                      onTap: () async {
                        var data = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000, 1, 1),
                            firstDate: DateTime(1900, 5, 20),
                            lastDate: DateTime(2023, 10, 23));
                        if (data != null) {
                          dataNascimentoController.text = data.toString();
                          dadosCadastraisModel.dataNascimento = data;
                        }
                      },
                      controller: dataNascimentoController,
                      readOnly: true,
                    ),
                    const TextLabel(
                      texto: 'Nível de experiência',
                    ),
                    Column(
                      children: niveis
                          .map((nivel) => RadioListTile(
                              dense: true,
                              title: Text(nivel.toString()),
                              selected: dadosCadastraisModel.nivelExperiencia ==
                                  nivel.toString(),
                              value: nivel.toString(),
                              groupValue: dadosCadastraisModel.nivelExperiencia,
                              onChanged: (value) {
                                setState(() {
                                  dadosCadastraisModel.nivelExperiencia =
                                      value.toString();
                                });
                              }))
                          .toList(),
                    ),
                    const TextLabel(
                      texto: 'Linguagens preferidas',
                    ),
                    Column(
                      children: linguagens
                          .map((linguagem) => CheckboxListTile(
                              dense: true,
                              title: Text(linguagem),
                              value: dadosCadastraisModel.linguagens
                                  .contains(linguagem),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    dadosCadastraisModel.linguagens
                                        .add(linguagem);
                                  } else {
                                    dadosCadastraisModel.linguagens
                                        .remove(linguagem);
                                  }
                                });
                              }))
                          .toList(),
                    ),
                    const TextLabel(
                      texto: 'Tempo de experiência',
                    ),
                    DropdownButton(
                        isExpanded: true,
                        value: dadosCadastraisModel.tempoExperiencia,
                        items: returnItens(50),
                        onChanged: (value) {
                          setState(() {
                            dadosCadastraisModel.tempoExperiencia = value ?? 0;
                          });
                        }),
                    TextLabel(
                      texto:
                          'Pretensão salarial. R\$ ${dadosCadastraisModel.salario?.round().toString()}',
                    ),
                    Slider(
                        min: 0,
                        max: 10000,
                        value: dadosCadastraisModel.salario ?? 0.0,
                        onChanged: (value) {
                          setState(() {
                            dadosCadastraisModel.salario = value;
                          });
                        }),
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            salvando = true;
                          });

                          if (nomeController.text.trim().length < 3) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("O nome deve ser preenchido")));
                            return;
                          }

                          if (dadosCadastraisModel.dataNascimento == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Data de nascimento inválida")));
                            return;
                          }

                          if ((dadosCadastraisModel.nivelExperiencia ?? "")
                              .trim()
                              .isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("O nível deve ser selecionado")));
                            return;
                          }

                          if (dadosCadastraisModel.linguagens.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Deve ser selecionado ao menos uma linguagem")));
                            return;
                          }

                          if ((dadosCadastraisModel.tempoExperiencia ?? 0) ==
                              0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Deve ter ao menos um ano de experiência em uma das linguagens")));
                            return;
                          }

                          if ((dadosCadastraisModel.salario ?? 0.0) == 0.0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "A pretensão salarial deve ser maior que 0")));
                            return;
                          }

                          dadosCadastraisModel.nome = nomeController.text;

                          dadosCadastraisRepository
                              .salvar(dadosCadastraisModel);

                          setState(() {
                            salvando = true;
                          });

                          Future.delayed(const Duration(milliseconds: 500), () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Dados salvos com sucesso")));
                            setState(() {
                              salvando = false;
                            });
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Salvar"))
                  ],
                )),
    );
  }
}
