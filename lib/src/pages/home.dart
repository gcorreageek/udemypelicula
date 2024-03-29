import 'package:flutter/material.dart';
import 'package:proy_udemy_peliculas/src/providers/peliculas_provider.dart';
import 'package:proy_udemy_peliculas/src/widgets/card_page.dart';
import 'package:proy_udemy_peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Peliculas Apps'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_swipperTarjetas(), _footer(context)],
      )),
    );
  }

  Widget _swipperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwipper(
            listaPeliculas: snapshot.data,
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares444',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          // poster_path
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
