import 'package:flutter/material.dart';
import 'package:proy_udemy_peliculas/src/pages/home.dart';
import 'package:proy_udemy_peliculas/src/pages/pelicula_detalle.dart'; 

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        "/": (context) => HomePage(),
        "detalle": (context) => PeliculaDetalle(),
      },
    );
  }

}
