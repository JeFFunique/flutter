
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'variables.dart';
import 'package:projet/main_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Whishs extends StatefulWidget {

  const Whishs({ Key? key}) : super(key: key);

  @override
  State<Whishs> createState() => _WhishsState();
}

class _WhishsState extends State<Whishs> {



  Future<Game> fetch1game(int gameId) async {
    final response = await http.get(Uri.parse(
        'https://store.steampowered.com/api/appdetails?appids=${gameId}'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(
          response.body)["${gameId}"]["data"];
      return Game.fromJson(data);
    }
    else {
      throw Exception('failed');
    }


  }

  fetchDescription() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ma Liste de Souhaits"),
          backgroundColor: const Color(0xFF1A2025),

        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.builder(
                              itemCount:wishedGamesID.length,
                              itemBuilder:(context, index) {
                                final iD =wishedGamesID.keys.toList()[index];
                                final game = games.firstWhere((game) => game.id == iD);

                                return Container(
                                    child: Row(
                                        children: [
                                          Expanded(
                                              child: ListTile(
                                                  title: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Image.network(game.image, fit: BoxFit.cover),
                                                        const SizedBox(height: 16,),
                                                        Text('Nom du jeu : ${game.name}'),
                                                        const SizedBox(height: 16,),
                                                        Text('Nom de l editeur: ${game.editor}'),
                                                        const SizedBox(height: 16,),
                                                        Text('Prix: ${game.price}'),
                                                        const SizedBox(height: 16,),
                                                        TextButton(onPressed: fetchDescription(), child: Text('EN SAVOIR PLUS'))




                                                      ]
                                                  )))]));
                              })
                        ]



                    )

                )
            )
        )
    );
  }
}



















