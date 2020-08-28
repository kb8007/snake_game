import 'package:flutter/material.dart';
import 'package:snake_game/pages/game.dart';
import 'package:snake_game/pages/home.dart';

void main() {
    runApp(MaterialApp(
        initialRoute: '/home',
        routes: {
            '/home': (context) => Home(),
            '/game': (context) => Game()
        },
    ));
}