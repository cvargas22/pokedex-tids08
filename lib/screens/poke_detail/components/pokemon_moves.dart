import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_moves_model.dart';


class PokemonMoves extends StatelessWidget {
  //declarar atributo nombrepokemon
  //declarar atributo tipopokemon(tipo1)
  //crear el constructor que solicite ambos atributos

  //crear una instancia del api provider
  List<Moves> moves = [];
  @override
  Widget build(BuildContext context) {
    //Crear container con FutureBuilder para mostrar los datos
    //Widget que podrian servir: Container, Column, Expanded, ListView, estos widget son solo para posicionar o disponer elementos
    //Widget obligatorio: Wrap
    return Center(
      child: Wrap(
        children: moves.map((move) => Container(

          child: Text(move.move.name),
        )
        ).toList(),
      ),
    );
  }
}