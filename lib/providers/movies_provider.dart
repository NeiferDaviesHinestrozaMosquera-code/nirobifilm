
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nirobifilm/helper/debouncer.dart';
import 'package:nirobifilm/models/models.dart';
import 'package:nirobifilm/models/search_movies.dart';

class MoviesProvider extends ChangeNotifier{

String _baseUrl = 'api.themoviedb.org';
String _apiKey = '478acd0d5df5455bb5c4b27d6ab13b66';
String _language = 'es-ES';

List<Movie> onDisplayMovies = [];
List<Movie> popularMovies = [];

Map <int , List<Cast>> moviesCast = {};  ////////LISTA D ELOS ACTORES

int _popularPage = 0;

final debouncer = Debouncer(duration: Duration(milliseconds: 500),
// onValue: (value) => ,
);

final StreamController <List<Movie>> _suggestionStreamController = new StreamController.broadcast();

Stream <List<Movie>> get suggestionStream => this._suggestionStreamController.stream;



  MoviesProvider(){
    print('Movies providers');

    this.getOnDisplayMovies();
    this.getPopularMovies();
    
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('/3/movie/now_playing');
    final nowPlaying =  NowPlaying.fromJson(jsonData);


    onDisplayMovies = nowPlaying.results;
    notifyListeners();////NOTIFICAR A LOS WIDGETS
  }

       Future <String>_getJsonData( String endpoint ,[ int page =1] ) async{
       final url = Uri.https(_baseUrl, endpoint, ///LISTA DE
    {  
       'api_key' : _apiKey,
       'language' : _language,
       'page': '$page'
       }
       );

  // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
          }

  getPopularMovies() async{

    _popularPage ++;
    final jsonData = await this._getJsonData('/3/movie/popular', _popularPage);
    final popular =  Popular.fromJson(jsonData);


    popularMovies = [...popularMovies ,...popular.results];

    notifyListeners();////NOTIFICAR A LOS WIDGETS
  }

  Future <List <Cast>> getMovieCast (int movieId) async {

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await this._getJsonData('/3/movie/$movieId/credits');
    final credits = Credits.fromJson(jsonData);

    moviesCast[movieId] = credits.cast;
    return credits.cast;
  }

  Future <List<Movie>> searchMovies (String query) async {


     final url = Uri.https(_baseUrl, '3/search/movie', ///LISTA DE
    {  
       'api_key' : _apiKey,
       'language' : _language,
       'query' : query
       }
       );

    final response = await http.get(url);
    final searchmovies = Search.fromJson(response.body);

    return searchmovies.results;
  }

void getSuggestionsByQuery(String searchTerm){
    debouncer.value = " ";
    debouncer.onValue = (value) async {
        final results = await this.searchMovies(value);
        this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300),((_) {
      debouncer.value = searchTerm;
    }));

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
}


}