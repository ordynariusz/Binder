import 'package:binder/models/axie_data.dart';
import 'package:binder/models/sorare_data.dart';
import 'package:flutter/material.dart';

class TokenAttributeModel {
  final String name;
  final String value;

  TokenAttributeModel({
    @required this.name,
    @required this.value,
  });
}

class TokenSlotModel {
  final String img;
  final String name;
  final String collection;
  final String description;
  final List<TokenAttributeModel> attributes;

  TokenSlotModel(
      {@required this.name,
      @required this.img,
      @required this.collection,
      this.description,
      this.attributes});
}

class BinderPageModel {
  final TokenSlotModel s1;
  final TokenSlotModel s2;
  final TokenSlotModel s3;
  final TokenSlotModel s4;

  BinderPageModel({
    this.s1,
    this.s2,
    this.s3,
    this.s4,
  });
}

class BinderModel {
  final String owner;
  final String title;
  final String id;
  final String cover;
  final String frame;
  final String description;
  final List<BinderPageModel> pages;

  BinderModel({
    @required this.owner,
    @required this.title,
    @required this.pages,
    @required this.id,
    @required this.cover,
    @required this.frame,
    @required this.description,
  });
}

final List<BinderPageModel> pokemonBinderPages = [
  for (int i = 0; i < 8; i++)
    BinderPageModel(
      s1: TokenSlotModel(
        name: 'Blastoise',
        img: 'images/pokemon/Blastoise.jpg',
        collection: 'Pokemon',
      ),
      s2: TokenSlotModel(
        name: 'Bulbasaur',
        img: 'images/pokemon/bulbasaur.jpg',
        collection: 'Pokemon',
      ),
      s3: TokenSlotModel(
        name: 'Pikachu',
        img: 'images/pokemon/pikachu.jpg',
        collection: 'Pokemon',
      ),
      s4: TokenSlotModel(
        name: 'Charizard',
        img: 'images/pokemon/Charizard.jpg',
        collection: 'Pokemon',
      ),
    ),
];

final Map<String, BinderModel> binders = {
  'default': BinderModel(
    owner: 'Steve',
    title: 'My pokemons',
    pages: pokemonBinderPages,
    id: 'default',
    cover: 'images/binder_outside.png',
    description: '',
    frame: '',
  ),
  'sorare': BinderModel(
    owner: 'Steve',
    title: 'Sorare',
    pages: soRareBinderPages,
    id: 'sorare',
    cover: 'images/binder_outside.png',
    description: '',
    frame: '',
  ),
  'axie': BinderModel(
    owner: 'Johny',
    title: 'Axie Infinity',
    pages: axieBinderPages,
    id: 'axie',
    cover: 'images/binder_outside.png',
    description: '',
    frame: '',
  ),
};
