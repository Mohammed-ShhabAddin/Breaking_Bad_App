// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:breaking_bad_app/data/models/characters.dart';
import 'package:breaking_bad_app/data/models/quote.dart';
import 'package:breaking_bad_app/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getCharacterQuotes(String charName) {
    charactersRepository.getCharacterQuote(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
