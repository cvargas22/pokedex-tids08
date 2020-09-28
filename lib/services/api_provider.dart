import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon_list_model.dart';

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
}