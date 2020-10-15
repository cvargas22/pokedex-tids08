import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_stats_model.dart';
import 'package:pokedex/services/api_provider.dart';


class PokemonStats extends StatelessWidget {
  final String nombrePokemon;
  PokemonStats({
    this.nombrePokemon
  });
  final ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: FutureBuilder<PokemonStatsModel>(
        future: apiProvider.obtenerInfoStatsPokemon(nombrePokemon),
        builder: (BuildContext context, AsyncSnapshot<PokemonStatsModel> snapshot){
          if(snapshot.hasData){
            return Text('Ok');
          }
          else{
            return Column(
              children: [
                CircularProgressIndicator()
              ],
            );
          }
        },
      ),
    );
  }
}