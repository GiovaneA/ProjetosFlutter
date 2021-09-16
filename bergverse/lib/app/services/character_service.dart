import 'package:bergverse/app/entidades/character.dart';
import 'package:bergverse/app/interfaces/character_dao.dart';
import 'package:get_it/get_it.dart';

class CharacterService {
  var _dao = GetIt.I.get<CharacterDAO>();

  save(Character c) {
    _dao.save(c);
  }

  remove(int id) {
    _dao.remove(id);
  }

  Future<List<Character>> find() {
    return _dao.find();
  }
}
