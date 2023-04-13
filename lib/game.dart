import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game {
  final int id;
  final String image;
  final String name;
  final String editor;
  final int price;


  Game({required this.id,
    required this.image,
    required this.name,
    required this.editor,
    required this.price,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(id: json['appid'] ,
        image: json["header_image"] ,
        name: json["name"] ,
        editor: json["publishers"][0],
        price: 15);
  }

}


