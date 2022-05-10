
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';


class CardSiwper extends StatelessWidget {
 

  final List<Movie> movies;

  const CardSiwper({Key? key, required this.movies}) : super( key:key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    if (this.movies.length == 0){
      return Container(
        width: double.infinity,
        height: size.height *0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }


    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      
      child: Swiper(
        itemCount:movies.length ,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_ , int index){


          final movie = movies[index];

          movie.heroId = 'swiper-${movie.id}';  ///INDIVIDUALIZAR CADA ANIMACION

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details' , arguments: movie) ,
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(   ////ESTE SE ENCARGA DE REDONDEAR LA IMAGEN DENTRO DE LA CARDS
                borderRadius: BorderRadius.circular(20),
                child:  FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                  ),
              ),
            ),
          );
        },
        )
    );
  }
}