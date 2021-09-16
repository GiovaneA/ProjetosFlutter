import 'package:bergverse/app/entidades/character.dart';
import 'package:bergverse/app/my_app.dart';
import 'package:bergverse/app/services/character_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';


part 'character_list_back.g.dart';

class CharacterListBack = _CharacterListBack with _$CharacterListBack;

abstract class _CharacterListBack with Store {
  var _service = GetIt.I.get<CharacterService>();

  @observable
  Future<List<Character>>? list;

  @action
  refreshList([dynamic value]) {
    list = _service.find();
  }

  _CharacterListBack() {
    refreshList();
  }

  goToForm(BuildContext context, [Character? character]) {
    Navigator.of(context)
        .pushNamed(MyApp.CHARACTER_FORM, arguments: character)
        .then(refreshList);
  }

  remove(int id) {
    _service.remove(id);
    refreshList();
  }
}
