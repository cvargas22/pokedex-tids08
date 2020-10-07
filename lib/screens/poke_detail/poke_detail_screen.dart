import 'package:flutter/material.dart';
import 'package:pokedex/helpers/colorTheme.dart';
import 'package:pokedex/helpers/customWidget.dart';
import 'package:pokedex/models/pokemon_list_model.dart';

class PokemonDetailScreen extends StatefulWidget {
  final PokemonListModel pokemon;
  PokemonDetailScreen({this.pokemon});

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> with TickerProviderStateMixin{
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000)
    );
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: setprimaryColor(widget.pokemon.type1),
      body: Stack(
        children: [
          _pokebolaRotandoArriba(),
          Positioned(
            left: 10,
            top: getDimention(context, 40),
            child: BackButton(
              color: Colors.white60,
            ),
          )
        ],
      ),
    );
  }

  Widget _pokebolaRotandoArriba() {
    return Positioned(
      right: -20,
      top: -20,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(controller),
        child: Image.asset(
          'assets/images/pokeball.png',
          height: getDimention(context, 250),
          color: Color(0xffe3e3e3).withAlpha(100),
        ),
      ),
    );
  }
}
