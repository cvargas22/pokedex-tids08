import 'package:flutter/material.dart';
import 'package:pokedex/screens/home/home_screen.dart';
import 'package:pokedex/screens/poke_detail/poke_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      initialRoute: '/',
      routes: <String,WidgetBuilder>{
        '/': (BuildContext context) => HomeScreen(),
        'poke-detail': (BuildContext context) => PokemonDetailScreen()
      },
    );
  }
}
