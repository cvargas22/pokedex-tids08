import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_list_model.dart';
import 'package:pokedex/services/api_provider.dart';

class HomeScreen extends StatelessWidget {
  final ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 100,
                  flexibleSpace: Container(
                    padding: EdgeInsets.symmetric(vertical:20),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Pokedex',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                FutureBuilder<List<PokemonListModel>>(
                  future: apiProvider.obtenerListaPokemon(),
                  builder: (BuildContext context, AsyncSnapshot<List<PokemonListModel>> snapshot){
                    if(snapshot.hasData){
                      print(snapshot.data[10].name);
                      return SliverGrid.count(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        children: [
                          Center(
                            child: Text('${snapshot.data[10].name}'),
                          )
                        ],
                      );
                    }
                    else if(snapshot.hasError){
                      return SliverGrid.count(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        children: [
                          Center(
                            child: Text('No se han podido obtener los datos desde el servidor'),
                          )
                        ],
                      );
                    }
                    else{
                      return SliverGrid.count(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
