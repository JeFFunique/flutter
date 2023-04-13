import 'package:flutter/material.dart';
class GameRank {
  final int rank;
  final int id;

  GameRank({required this.rank,
    required this.id});
  factory GameRank.fromJson(Map<String, dynamic> json){
return GameRank(
    id: json["appid"],
    rank: json["rank"],
);
  }

}