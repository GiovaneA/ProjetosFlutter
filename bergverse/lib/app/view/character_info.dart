import 'dart:convert';

import 'package:bergverse/app/entidades/character.dart';
import 'package:flutter/material.dart';

class CharacterInfo extends StatefulWidget {
  @override
  _CharacterInfoState createState() => _CharacterInfoState();
}

DecorationImage decorationImage(String img) {
    if (img.isNotEmpty) {
      return DecorationImage(image: MemoryImage(base64.decode(img.toString())));
    } else {
      return DecorationImage(image: AssetImage('assets/img_error.png'));
    }
  }

class _CharacterInfoState extends State<CharacterInfo> {
  @override
  Widget build(BuildContext context) {
    var char = ModalRoute.of(context)?.settings.arguments as Character;
    return Scaffold(
      appBar: AppBar(title: Text("Informações"), actions: []),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
          child: Center(
           child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: decorationImage(char.img.toString()),
                    border: Border.all(width: 3, color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
                ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Card(
            elevation: 15,
            child: Column(
            children:[ 
              Center(
              child: Text(char.nome.toString(),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
              ),
              Padding(padding: EdgeInsets.all(10),
               child: RichText(
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                text: TextSpan(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black,),
                  text: char.descricao,
                )
                ),
            ),            
            ],
              ),
            ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Card(
                elevation: 15,
                child: Padding(
                  padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Informações",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                        RichText(
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                        text: TextSpan(
                          text: '\nRaça/Especie:\n',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey, ),
                          children: <TextSpan>[
                            TextSpan(
                              text: char.raca,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black, )
                            )
                          ],
                        ),
                        ),
                      RichText(
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                        text: TextSpan(
                          text: '\nIdade:\n',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey, ),
                          children: <TextSpan>[
                            TextSpan(
                              text: char.idade,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black, )
                            )
                          ],
                        ),                   
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                        text: TextSpan(
                          text: '\nAltura:\n',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey, ),
                          children: <TextSpan>[
                            TextSpan(
                              text: char.altura.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black, )
                            )
                          ],
                        ),                       
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                        text: TextSpan(
                          text: '\nGenero:\n',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey, ),
                          children: <TextSpan>[
                            TextSpan(
                              text: char.genero,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black, )
                            )
                          ],
                        ),                        
                        ),
                      ],
                      ),
                      ),
                  ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
