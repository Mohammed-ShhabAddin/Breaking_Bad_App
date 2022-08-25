import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constans/app_colors.dart';
import '../../data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(
            color: AppColors.white,
          ),
          //textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charid,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: AppColors.yellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(color: AppColors.white, fontSize: 16),
        )
      ]),
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          style:
              const TextStyle(fontSize: 20, color: AppColors.white, shadows: [
            Shadow(blurRadius: 7, color: AppColors.yellow, offset: Offset(0, 0))
          ]),
          textAlign: TextAlign.center,
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote)
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.yellow),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getCharacterQuotes(character.name);
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo("Job : ", character.jobs.join(' / ')),
                    buildDivider(250),
                    characterInfo(
                        "appeared in  : ", character.categoryForTowSeries),
                    buildDivider(250),
                    characterInfo("seasons : ",
                        character.appearaenceOfseasons.join(' / ')),
                    buildDivider(280),
                    characterInfo("status : ", character.statesIfDeadOrAlive),
                    buildDivider(300),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : characterInfo("beatter call saul appearance : ",
                            character.betterCallSaulAppearance.join(' / ')),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : buildDivider(150),
                    characterInfo("Actor/Actress : ", character.actorName),
                    buildDivider(235),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharactersCubit, CharactersState>(
                        builder: ((context, state) {
                      return checkIfQuotesAreLoaded(state);
                    })),
                  ],
                ),
              ),
              const SizedBox(
                height: 300,
              )
            ]),
          )
        ],
      ),
    );
  }
}
