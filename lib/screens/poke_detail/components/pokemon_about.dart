import 'package:flutter/material.dart';
import 'package:pokedex/helpers/customWidget.dart';
import 'package:pokedex/models/pokemon_about_location_model.dart';
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
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: fullWidth(context),
      child: FutureBuilder<PokemonAboutModel>(
        future: apiProvider.obtenerInfoAboutPokemon(nombrePokemon),
        builder: (BuildContext context, AsyncSnapshot<PokemonAboutModel> snapshot){
          if(snapshot.hasData){
            FlavorTextEntries aboutText = snapshot.data.pokeSpecies.flavorTextEntries.firstWhere(
              (ftext) => ftext.language.name == 'es'
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  aboutText.flavorText,
                ),
                crearPesoAlturaPokemon(
                  snapshot.data.pokeDetail.weight, 
                  snapshot.data.pokeDetail.height,
                  context
                ),
                SizedBox(height: 15),
                Text(
                  'Crianza',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: getFontSize(context, 16)
                  ),
                ),
                SizedBox(height: 10,),
                crearEggGroup(snapshot.data.pokeSpecies.eggGroups, context),
                SizedBox(height: 10,),
                Text(
                  'Ubicación',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: getFontSize(context, 16)
                  ),
                ),
                crearUbicaciones(snapshot.data.pokeLocations, context)

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

  Widget crearPesoAlturaPokemon(int weight, int height, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: fullWidth(context),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
            offset: Offset(0,5)
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text('Peso'),
              SizedBox(height: fullHeight(context)*0.01 ),
              Text('$weight lbs')
            ],
          ),
          Column(
            children: [
              Text('Altura'),
              SizedBox(height: fullHeight(context)*0.01 ),
              Text('$height plg')
            ],
          )
        ],
      ),
    );
  }

  Widget crearEggGroup(List<EggGroups> eggGroups, BuildContext context) {
    return Container(
      width: fullWidth(context),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Egg Groups',
              style: TextStyle(
                fontSize: getFontSize(context, 14),
                color: Colors.black45,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Wrap(
              children: eggGroups.map((item) => Container(
                padding: EdgeInsets.only(right:10),
                child: Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black
                  ),
                ),
              )).toList()
            ),
          )
        ],
      ),
    );
  }

  Widget crearUbicaciones(List<PokeAboutLocation> pokeLocations, BuildContext context) {
    return Container(
      width: fullWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: pokeLocations.map((location) => Container(
          padding: EdgeInsets.only(top:5),
          child: Text(
            location.locationArea.name
          ),
        )).toList(),
      ),
    );
  }
}