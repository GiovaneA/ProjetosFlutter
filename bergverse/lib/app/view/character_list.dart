import 'dart:convert';

import 'package:bergverse/app/entidades/character.dart';
import 'package:bergverse/app/my_app.dart';
import 'package:bergverse/app/view/character_list_back.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';

class CharacterList extends StatelessWidget {
  CharacterList({Key? key}) : super(key: key);

  final _back = CharacterListBack();

  DecorationImage decorationImage(String img) {
    if (img.isNotEmpty) {
      return DecorationImage(image: MemoryImage(base64.decode(img.toString())));
    } else {
      return DecorationImage(image: AssetImage('assets/img_error.png'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Personagens"), actions: [
        IconButton(
            onPressed: () {
              _back.goToForm(context);
            },
            icon: Icon(Icons.add))
      ]),
      body: Observer(builder: (context) {
        return FutureBuilder<List<dynamic>>(
            future: _back.list,
            builder: (context, futuro) {
              if (!futuro.hasData) {
                return CircularProgressIndicator();
              } else {
                List<Character> lista = futuro.data as List<Character>;
                if (lista.isEmpty) {
                  return Center(
                    child: Card(
                    elevation: 15,
                    
                    child: Text('Nenhum personagem adicionado',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  )
                  )
                  );
                } else {
                  return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: lista.length,
                      itemExtent: 145,
                      itemBuilder: (context, i) {
                        var char = lista[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                MyApp.CHARACTER_INFO,
                                arguments: char);
                          },
                          child: Container(
                            child: Card(
                              elevation: 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: decorationImage(
                                            char.img.toString()),
                                        border: Border.all(
                                            width: 3, color: Colors.lightBlue),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 4,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 10, 10, 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                char.nome.toString(),
                                                style: const TextStyle(
                                                  fontSize: 22.0,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1),
                                              ),
                                              Text(
                                                char.descricao.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                                maxLines: 5,
                                              )
                                            ],
                                          ))),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _back.goToForm(context, char);
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: Text('Excluir'),
                                                        content: Text(
                                                            'Deseja realmente excluir?'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child:
                                                                  Text('Não')),
                                                          TextButton(
                                                              onPressed: () {
                                                                _back.remove(char
                                                                    .id!
                                                                    .toInt());
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child:
                                                                  Text('Sim'))
                                                        ],
                                                      ));
                                            },
                                            icon: Icon(Icons.delete))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              }
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //fab action
          _back.goToForm(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
