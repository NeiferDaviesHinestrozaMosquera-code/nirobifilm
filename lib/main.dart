
import 'package:flutter/material.dart';
import 'package:nirobifilm/providers/movies_provider.dart';
import 'package:nirobifilm/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());


class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider() , lazy: false,
          )
       ],
       child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
     initialRoute: 'home',
     routes: {
       'home':(_) => HomeScreen(),
       'details':(_) => const DetailsScreen(),
     },
     theme: ThemeData.light().copyWith(
       appBarTheme: const AppBarTheme(
         color: Colors.indigoAccent
       )
     ),
    );
  }
}