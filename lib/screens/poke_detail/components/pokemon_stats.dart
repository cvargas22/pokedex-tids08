import 'package:flutter/material.dart';
import 'package:pokedex/helpers/customWidget.dart';
import 'package:pokedex/models/pokemon_stats_detail_model.dart';
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
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: fullWidth(context),
      child: FutureBuilder<PokemonStatsModel>(
        future: apiProvider.obtenerInfoStatsPokemon(nombrePokemon),
        builder: (BuildContext context, AsyncSnapshot<PokemonStatsModel> snapshot){
          if(snapshot.hasData){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                crearStats(snapshot.data.pokeStatDetail.stats, context),
              ],
            );
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

  Widget crearStats(List<Stats> stats, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: stats.map((stat) => Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    stat.stat.name
                  ),
                ),
                Text(
                  '${stat.baseStat}'
                )
              ],
            )
          ],
        )).toList(),
      ),
    );
  }
}