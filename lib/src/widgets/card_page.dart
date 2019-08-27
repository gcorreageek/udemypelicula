import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:proy_udemy_peliculas/models/pelicula_model.dart';

class CardSwipper extends StatelessWidget {
  final List<Pelicula> listaPeliculas;

  CardSwipper({@required this.listaPeliculas});

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screensize.width * 0.7,
        itemHeight: _screensize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(listaPeliculas[index].getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: listaPeliculas.length,
      ),
    );
  }
}
