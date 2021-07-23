import 'package:breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/data/repository/characters_repository.dart';
import 'package:breakingbad/presentation/screens/CharacterDetailsScreen.dart';
import 'package:breakingbad/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/strings.dart';
import 'data/web_services/characters_web_services.dart';

class AppRouter {
  CharactersRepository charactersRepository;
  CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (BuildContext context) => charactersCubit,
              child: CharactersScreen()),
        );
        break;
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => CharactersCubit(charactersRepository),
                  child: CharacterDetailsScreen(
                    character: character,
                  ),
                ));
        break;
      default:
        return MaterialPageRoute(builder: (_) => CharactersScreen());
    }
  }
}
