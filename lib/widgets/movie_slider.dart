import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nirobifilm/models/models.dart';

class MovieSlider extends StatefulWidget {
  
final  List<Movie> movies;
final String? title;
final Function onNextPage;

  const MovieSlider({Key? key, required this.movies, this.title, required this.onNextPage}) : super( key:key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {



final ScrollController scrollcontroller = new ScrollController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollcontroller.addListener(() {
      if(scrollcontroller.position.pixels >= scrollcontroller.position.maxScrollExtent - 500){

       widget.onNextPage();
      }
      //print(scrollcontroller.position.pixels); ///ESTO SE EJECUTA EN CONSOLA Y MUESTRA EL VALOR DE LAS POSICIONES
      //print(scrollcontroller.position.maxScrollExtent); ///VALOR MAXIMO DE LOS VALORES
    });
  }


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260 ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          if(this.widget.title != null)
              Padding(padding: EdgeInsets.symmetric(horizontal: 20,),
              child:Text(this.widget.title! ,style: TextStyle(fontSize: 30 , fontWeight: FontWeight.normal), 
                ),
              ),


     SizedBox(height: 5,),

     
          Expanded(
            child: ListView.builder(
              controller: scrollcontroller, ///HACE REFERENCIA A EL VALOR DE ARRIBA
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => _MoviePoster(widget.movies[index] , '${widget.title}-${index}-${widget.movies[index].id}')
              ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  ///DEBE RECIBIR UN MOVIE CON FINAL

  final Movie  movie ;
  final String heroId;

  const _MoviePoster (this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;
    return Container(
              width: 130,
              height: 190,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'details' , arguments: movie) ,
                    child: Hero( ///ANIMACIONES
                      tag: movie.heroId!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/no-image.jpg'),
                           image: NetworkImage(movie.fullPosterImg),
                           width: 130,
                           height: 190,
                           fit: BoxFit.cover,
                           ),
                      ),
                    ),
                  ),


                        SizedBox(height: 5,),


                     Text(movie.title,
                     overflow: TextOverflow.ellipsis,
                     textAlign: TextAlign.center,
             ),        
          ],
        ),
     );
  }
}