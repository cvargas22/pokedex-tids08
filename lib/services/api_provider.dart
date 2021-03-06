import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon_about_detail_model.dart';
import 'package:pokedex/models/pokemon_about_location_model.dart';
import 'package:pokedex/models/pokemon_about_model.dart';
import 'package:pokedex/models/pokemon_about_species_model.dart';
import 'package:pokedex/models/pokemon_list_model.dart';
import 'package:pokedex/models/pokemon_stats_detail_model.dart';
import 'package:pokedex/models/pokemon_stats_model.dart';
import 'package:pokedex/models/pokemon_stats_species_model.dart';

class ApiProvider{
  Dio dio = Dio();

  Future<List<PokemonListModel>> obtenerListaPokemon() async{
    List<PokemonListModel> lista = [];
    try {
      Response resp = await dio.get('https://pokedexvuejs.herokuapp.com/pokedexdb');
      final pokemones = PokemonListResponse.fromJsonList(resp.data);
      lista = pokemones.items;
    } catch (e) {

    }
    return lista;
  }

  Future<PokemonAboutModel> obtenerInfoAboutPokemon(String nombrePoke) async{
    var pokeAbout = PokemonAboutModel();
    try {
      Response respA = await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      final pokeDetail = PokeAboutDetail.fromJson(respA.data);
      Response respB = await dio.get('https://pokeapi.co/api/v2/pokemon/${pokeDetail.id}/encounters');
      final pokeListLocation = PokemonAboutLocationListModel.fromJsonList(respB.data);
      Response respC = await dio.get('https://pokeapi.co/api/v2/pokemon-species/${pokeDetail.id}');
      final pokeSpecies = PokeAboutSpecies.fromJson(respC.data);

      pokeAbout = PokemonAboutModel(
        pokeDetail: pokeDetail,
        pokeLocations: pokeListLocation.items,
        pokeSpecies: pokeSpecies
      );

    } catch (e) {

    }

    return pokeAbout;
  }

  Future<PokemonStatsModel> obtenerInfoStatsPokemon(String nombrePoke) async{
    var pokeStats = PokemonStatsModel();
    try {
      Response respA = await dio.get('https://pokeapi.co/api/v2/pokemon/$nombrePoke');
      final pokeStatDetail = PokeStatsDetail.fromJson(respA.data);
      Response respB = await dio.get('https://pokeapi.co/api/v2/pokemon-species/${pokeStatDetail.id}');
      final pokeStatSpecies = PokeStatsSpecies.fromJson(respB.data);

      pokeStats = PokemonStatsModel(
        pokeStatDetail: pokeStatDetail,
        pokeStatSpecies: pokeStatSpecies
      );
    } 
    catch (e) {
    }

    return pokeStats;

  }
  //crear un future que retorne el PokemonMovesModel y que reciba como parametro el nombre del pokemon
  //final pokeMoves = PokemonMovesModel.fromJson(response.data)

  //crear un future que retonar un PokemonEvolutionModel y que recibe como parametro el nombrePoke
  //primera llamada para obtener los datos de pokemon detail
  //crear el objeto que guarde el PokeEvolutionDetail.fromJson()
  //con ese objeta hacen la otra llamada con la url que viene de evolutionDetailResponse respX = await dio.get(pokeStatDetail.species.url);
  //crear el objeto que guarde el PokeEvolutionSpecies
  //la llamada final para obtener la evolutionChain
  //crear en ese objeto PokeEvolutionChain
  //asignan cada uno de los objetos al objeto principal PokemonEvolutionModel

}