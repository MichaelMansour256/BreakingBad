import 'package:breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:breakingbad/constants/colors.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> allCharacters;
  List<Character> searchedList;
  bool _isSearching = false;
  final _searchedTextController = TextEditingController();

  Widget _bulidSearchField() {
    return TextField(
      controller: _searchedTextController,
      cursorColor: MyColors.myGray,
      decoration: InputDecoration(
        hintText: "find a character ...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGray, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGray, fontSize: 18),
      onChanged: (searchedCharacter) {
        _addCharactersToSearchedList(searchedCharacter);
      },
    );
  }

  void _addCharactersToSearchedList(String searchedCharacter) {
    searchedList = allCharacters
        .where((element) =>
            element.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _bulidAppBarItems() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.myGray,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: MyColors.myGray,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchedTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndecator();
      }
    });
  }

  Widget showLoadingIndecator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGray,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchedTextController.text.isEmpty
          ? allCharacters.length
          : searchedList.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character: _searchedTextController.text.isEmpty
              ? allCharacters[index]
              : searchedList[index],
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.myGray),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearching
            ? BackButton(
                color: MyColors.myGray,
              )
            : Container(),
        title: _isSearching ? _bulidSearchField() : _buildAppBarTitle(),
        actions: _bulidAppBarItems(),
      ),
      body: buildBlocWidget(),
    );
  }
}
