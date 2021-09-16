import 'dart:convert';
import 'dart:io';
import 'package:bergverse/app/entidades/character.dart';
import 'package:bergverse/widgets/img_form.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bergverse/app/interfaces/character_dao.dart';
import 'package:get_it/get_it.dart';

class CharacterForm extends StatefulWidget {
  const CharacterForm({Key? key}) : super(key: key);

  @override
  _CharacterFormState createState() => _CharacterFormState();
}

class _CharacterFormState extends State<CharacterForm> {
  final _form = GlobalKey<FormState>();

  File? arquivo;
  final picker = ImagePicker();

  Future getFileFromGallery() async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => arquivo = File(file.path));
    }
  }

  Widget fieldImg(Character c) {
    return FormField(
      initialValue: ImgField(img64: c.img),
      onSaved: (newValue) => c.img = (arquivo != null)? base64.encode(arquivo!.readAsBytesSync()): c.img.toString(),
        builder: (field) => ImgField(
              img64: c.img,
              arquivo:  arquivo,
            ));
  }

  Widget btnImg() {
    return OutlinedButton.icon(
      icon: Icon(Icons.image),
      label: Text('Selecionar Imagem'),
      onPressed: () => getFileFromGallery(),
    );
  }

  Widget fieldNome(Character c) {
    return TextFormField(
      onSaved: (newValue) => c.nome = newValue,
      initialValue: c.nome,
      decoration: InputDecoration(labelText: 'Nome'),
      keyboardType: TextInputType.name,
    );
  }

  Widget fieldDesc(Character c) {
    return TextFormField(
      onSaved: (newValue) => c.descricao = newValue,
      initialValue: c.descricao,
      decoration: InputDecoration(labelText: 'Descrição'),
      maxLines: null,
      keyboardType: TextInputType.multiline,
    );
  }

  Widget fieldRaca(Character c) {
    return TextFormField(
      onSaved: (newValue) => c.raca = newValue,
      initialValue: c.raca,
      decoration: InputDecoration(labelText: 'Raça/Especie'),
      keyboardType: TextInputType.name
    );
  }

  Widget fieldIdade(Character c) {
    return TextFormField(
      onSaved: (newValue) => c.idade = newValue,
      initialValue: c.idade,
      decoration: InputDecoration(labelText: 'Idade'),
      keyboardType: TextInputType.name,
    );
  }

  Widget fieldAltura(Character c) {
    return TextFormField(
      onSaved: (newValue) => c.altura = newValue,
      initialValue: c.altura,
      decoration: InputDecoration(labelText: 'Altura'),
      keyboardType: TextInputType.number,
    );
  }

  Widget fieldGenero(Character c) {
    return TextFormField(
      onSaved: (newValue) => c.genero = newValue,
      initialValue: c.genero,
      decoration: InputDecoration(labelText: 'Gênero'),
      keyboardType: TextInputType.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    Character character;
    var parameter = ModalRoute.of(context)!.settings.arguments;
    character = (parameter == null) ? Character() : parameter as Character;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Personagem'),
        actions: [
          IconButton(
              onPressed: () {
                _form.currentState!.save();
                var _dao = GetIt.I.get<CharacterDAO>();
                _dao.save(character);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
        Form(
          key: _form,
          child: Column(
            children: [
              fieldImg(character),
              btnImg(),
              fieldNome(character),
              fieldDesc(character),
              fieldRaca(character),
              fieldIdade(character),
              fieldAltura(character),
              fieldGenero(character),
            ],
          ),
        ),
          ]
        ),
      ),
    );
  }
}
