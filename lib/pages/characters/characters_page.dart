import 'package:flutter/material.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:trilhaapp/repositories/marvel/marvel_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();
  late MarvelRepository _marvelRepository;
  late CharactersModel _charactersModel = CharactersModel();

  int offset = 0;
  bool loading = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      final posicaoPaginar = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > posicaoPaginar) {
        carregarDados();
      }
    });
    super.initState();
    _marvelRepository = MarvelRepository();
    carregarDados();
  }

  void carregarDados() async {
    if (loading) return;
    if (_charactersModel.data == null ||
        _charactersModel.data!.results == null) {
      _charactersModel = await _marvelRepository.getCharacters(offset);
    } else {
      setState(() {
        loading = true;
      });
      offset = offset + _charactersModel.data!.count!;
      final characters = await _marvelRepository.getCharacters(offset);
      _charactersModel.data!.results!.addAll(characters.data!.results!);
      loading = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
            "Heróis: ${offset + (_charactersModel.data?.count ?? 0)}/${_charactersModel.data?.total ?? 0}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _charactersModel.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                final character = _charactersModel.data!.results![index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          "${character.thumbnail!.path}.${character.thumbnail!.extension}",
                          width: 100,
                          height: 100,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Center(
                                  child: Text(character.description!),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (loading) const CircularProgressIndicator()
        ],
      ),
    ));
  }
}
