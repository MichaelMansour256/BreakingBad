import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/data/models/quote.dart';
import 'package:breakingbad/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<dynamic>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<dynamic>> getCharacterQuotes(String characterName) async {
    final quotes =
        await charactersWebServices.getCharacterQuotes(characterName);
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }
}
