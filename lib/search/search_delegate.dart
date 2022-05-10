

import 'package:flutter/material.dart';
import 'package:nirobifilm/models/models.dart';
import 'package:nirobifilm/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Buscar peliculas';  ///CAMBIO DE IDIOMA PARA LA BUSQUEDA 

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return[
     IconButton(icon: Icon(Icons.clear_all_outlined),
     onPressed: () {
        query = ''; ///LIMPIAR LA BUSQUEDA
     },)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (() {
      close(context, null);
    }), icon: Icon(Icons.arrow_back , color: Colors.red,));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('Buildresults');
  }

  Widget _emptyContainer(){
    return Container(
         child: Center(
           child: Icon(Icons.movie_creation_outlined , color: Colors.black, size: 130,),
         ),
       );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
     if (query.isEmpty){
       return _emptyContainer();
     }

     print('Hola http');

    final moviesProvider  = Provider.of<MoviesProvider>(context , listen: false);
    moviesProvider.getSuggestionsByQuery(query); ///LLAMADO DE STREAM

    
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_,AsyncSnapshot<List<Movie>> snapshot){

        if(!snapshot.hasData) return _emptyContainer();


        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItems(movies[index]),
        );
         
      }
      );
  }

}

class _MovieItems extends StatelessWidget {

  final Movie movie;

  const _MovieItems( this.movie);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('assets/no-image.jpg'), 
        image: NetworkImage(movie.fullPosterImg),
        width: 50,
        fit: BoxFit.contain,
        ),
      
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(
          context,'details', 
          arguments: movie
          );
      },
    );
  }
}