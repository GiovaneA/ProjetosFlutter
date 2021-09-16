import 'package:bergverse/app/view/character_form.dart';
import 'package:bergverse/app/view/character_info.dart';
import 'package:bergverse/app/view/character_list.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  static const HOME = '/';
  static const CHARACTER_INFO = 'character_info';
  static const CHARACTER_FORM = 'character_form';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HOME: (context) => CharacterList(),
        CHARACTER_INFO: (context) => CharacterInfo(),
        CHARACTER_FORM: (context) => CharacterForm(),
      },
    );
  }
}
