

import 'package:flutter/material.dart';
import 'package:nirobifilm/providers/movies_provider.dart';
import 'package:nirobifilm/search/search_delegate.dart';
import 'package:nirobifilm/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {

final moviesProvider = Provider.of<MoviesProvider> (context);
print(moviesProvider.onDisplayMovies);

    return Scaffold(

appBar: AppBar(
          title: const Text('Nirobi Film'),
          centerTitle: true,
          elevation: 0,
        actions: [
          IconButton(

            icon:Icon(Icons.search_off_outlined),

            onPressed: ()  => showSearch(
              context: context,
               delegate: MovieSearchDelegate()
               ), ///METODO DE  BUSQUEDA
           )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.purple, Colors.blue])),
          )),
      body :SingleChildScrollView(
        child: Column(
        children: [

          ////TODOOO : CARDSWIPER
          CardSiwper(movies :moviesProvider.onDisplayMovies ),

          ///SLIDER  DE PELIS
          MovieSlider(
            ///POPULARES
            movies : moviesProvider.popularMovies,///POPULARES
            title : 'Populares', ///POPULARES
            onNextPage: ()=> moviesProvider.getPopularMovies(), ///ACA SE HACE EL LLAMADO A LAS PELIS PUPULARES DEL METODO SLIDER
            ///TITULO OPCIONAL
          ),

        ],
      ),
      )
    );
  }
}