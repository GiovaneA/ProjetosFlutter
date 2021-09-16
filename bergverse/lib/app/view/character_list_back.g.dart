// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_list_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharacterListBack on _CharacterListBack, Store {
  final _$listAtom = Atom(name: '_CharacterListBack.list');

  @override
  Future<List<Character>>? get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(Future<List<Character>>? value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$_CharacterListBackActionController =
      ActionController(name: '_CharacterListBack');

  @override
  dynamic refreshList([dynamic value]) {
    final _$actionInfo = _$_CharacterListBackActionController.startAction(
        name: '_CharacterListBack.refreshList');
    try {
      return super.refreshList(value);
    } finally {
      _$_CharacterListBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}
