import 'package:bergverse/app/database/sqlite/connection.dart';
import 'package:bergverse/app/entidades/character.dart';
import 'package:bergverse/app/interfaces/character_dao.dart';
import 'package:sqflite/sqflite.dart';

class CharacterDAOImpl implements CharacterDAO {
  Database? _db;

  @override
  Future<List<Character>> find() async {
    _db = await Connection.get();
    List<Map<String, dynamic>> resultado = await _db!.query('character');
    List<Character> lista = List.generate(resultado.length, (i) {
      var linha = resultado[i];
      return Character(
          id: linha['id'],
          altura: linha['altura'],
          descricao: linha['descricao'],
          genero: linha['genero'],
          idade: linha['idade'],
          nome: linha['nome'],
          raca: linha['raca'],
          img: linha['img']);
    });

    return lista;
  }

  @override
  remove(int id) async {
    _db = await Connection.get();
    var sql = 'DELETE FROM character WHERE id=?';
    _db?.rawDelete(sql, [id]);
  }

  @override
  save(Character character) async {
    _db = await Connection.get();

    var sql;

    if (character.id == null) {
      sql =
          'INSERT INTO character(nome, idade, raca, altura, genero, descricao, img) VALUES(?,?,?,?,?,?,?)';
      _db?.rawInsert(sql, [
        character.nome,
        character.idade,
        character.raca,
        character.altura,
        character.genero,
        character.descricao,
        character.img
      ]);
    } else {
      sql =
          'UPDATE character SET nome=?, idade=?, raca=?, altura=?, genero=?, descricao=?, img=? WHERE id=?';
      _db?.rawUpdate(sql, [
        character.nome,
        character.idade,
        character.raca,
        character.altura,
        character.genero,
        character.descricao,
        character.img,
        character.id
      ]);
    }
  }
}
