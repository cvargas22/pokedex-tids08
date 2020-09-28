import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_list_model.dart';
import 'package:pokedex/services/api_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: FutureBuilder<List<PokemonListModel>>(
            future: apiProvider.obtenerListaPokemon(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PokemonListModel>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child:
                      GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ), 
                        itemBuilder: (context, int index){
                          return Text(snapshot.data[index].name);
                        },
                      ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
