// ignore_for_file: avoid_print

import 'package:breaking_bad_app/data/models/quote.dart';

import '../models/characters.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices chractersWebServices;

  CharactersRepository(this.chractersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await chractersWebServices.getAllCharacters();
    print("characters Repository:$characters");
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getCharacterQuote(String charName) async {
    final quotes = await chractersWebServices.getCharacterQuotes(charName);
    return quotes.map((charquote) => Quote.fromjson(charquote)).toList();
  }
}
