import 'package:bloc/bloc.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/data/models/quote.dart';
import 'package:breakingbad/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String characterName) {
    charactersRepository.getCharacterQuotes(characterName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
