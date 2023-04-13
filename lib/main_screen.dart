

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'variables.dart';

import '/game.dart';
import 'package:projet/gamerank.dart';

class  MainScreen extends StatefulWidget {

  const MainScreen({ Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Future<List<GameRank>> fetchGames() async {
    final response = await http
        .get(
        Uri.parse(
            'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/'));
    final result = jsonDecode(response.body);


    final element = result["response"]["ranks"];


    if (response.statusCode == 200) {
      gamesrank =
      List<GameRank>.from(element.map((json) => GameRank.fromJson(json)));
    }

    else
      throw Exception("failed");


    return gamesrank;
  }

  Future<List<Game>> fetchGamesFinal() async {
    gamesrank.map(
          (game) => games.add(fetch1game(game.id) as Game),
    );
    return games;
  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Steam app'),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: FutureBuilder<List<Game>>(
                    future: fetchGamesFinal(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return Text('No data');
                      } else {
                        games = snapshot.data!;
                        return ListView.builder(itemCount: games.length,
                            itemBuilder: (context, index) {
                              Game game = games[index];
                              return Container(

                                  child: Row(
                                      children: [
                                        const SizedBox(height: 16),
                                        Image.network(game.image, width: 100,
                                            height: 60,
                                            fit: BoxFit.cover),

                                        const SizedBox(height: 16),
                                        Text(
                                            game.name, style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,

                                        )
                                        ),
                                        const SizedBox(height: 16),

                                        Text(
                                          game.editor,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          '${game.price}',
                                        ),
                                      ]
                                  ));
                            });
                      }
                    }))));
  }
}








