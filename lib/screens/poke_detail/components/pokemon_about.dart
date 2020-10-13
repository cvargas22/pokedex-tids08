import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_about_model.dart';
import 'package:pokedex/models/pokemon_about_species_model.dart';
import 'package:pokedex/services/api_provider.dart';


class PokemonAbout extends StatelessWidget {
  final String nombrePokemon;
  PokemonAbout({this.nombrePokemon});
  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: FutureBuilder<PokemonAboutModel>(
        future: apiProvider.obtenerInfoAboutPokemon(nombrePokemon),
        builder: (BuildContext context, AsyncSnapshot<PokemonAboutModel> snapshot){
          if(snapshot.hasData){
            FlavorTextEntries aboutText = snapshot.data.pokeSpecies.flavorTextEntries.firstWhere(
              (ftext) => ftext.language.name == 'es'
            );
            return Column(
              children: [
                Text(aboutText.flavorText)
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
}