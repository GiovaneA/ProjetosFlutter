import 'package:bergverse/app/database/sqlite/dao/character_dao_impl.dart';
import 'package:bergverse/app/interfaces/character_dao.dart';
import 'package:bergverse/app/services/character_service.dart';
import 'package:get_it/get_it.dart';

setupInjection() {
  GetIt getIt = GetIt.I;

  getIt.registerSingleton<CharacterDAO>(CharacterDAOImpl());
  getIt.registerSingleton<CharacterService>(CharacterService());
}
