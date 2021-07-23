import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:breakingbad/constants/colors.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key key, this.character}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo("Job : ", character.jobs.join(' / ')),
                    buildDivider(315),
                    characterInfo(
                        "Appeared In : ", character.categoryForBBAndBCS),
                    buildDivider(250),
                    character.apperanceOfSeasons.isEmpty
                        ? Container()
                        : characterInfo("Seasons : ",
                            character.apperanceOfSeasons.join(' / ')),
                    character.apperanceOfSeasons.isEmpty
                        ? Container()
                        : buildDivider(280),
                    characterInfo("Status : ", character.statusIfDeadOrAlive),
                    buildDivider(300),
                    character.apperanceOfSeasonsBCS.isEmpty
                        ? Container()
                        : characterInfo("BCS seasons : ",
                            character.apperanceOfSeasonsBCS.join(' / ')),
                    character.apperanceOfSeasonsBCS.isEmpty
                        ? Container()
                        : buildDivider(250),
                    characterInfo("Actor/Actress : ", character.actorName),
                    buildDivider(240),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                      return checkIfQuotesLoaded(state);
                    })
                  ],
                ),
              ),
              SizedBox(
                height: 520,
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      thickness: 2,
      color: MyColors.myYellow,
    );
  }

  Widget checkIfQuotesLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return showRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndecator();
    }
  }

  Widget showRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(color: MyColors.myWhite, fontSize: 20, shadows: [
            Shadow(
                blurRadius: 7, color: MyColors.myYellow, offset: Offset(0, 0))
          ]),
          child: AnimatedTextKit(
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

  Widget showProgressIndecator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }
}
