import 'package:bergverse/app/entidades/character.dart';

abstract class CharacterDAO {
  save(Character character);

  remove(int id);

  Future<List<Character>> find();
}
