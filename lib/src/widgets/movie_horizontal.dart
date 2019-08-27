import 'package:flutter/material.dart';
import 'package:proy_udemy_peliculas/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
            siguientePagina();
          }
    });
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemBuilder: (context , i ){
          return _crearTarjeta(context,peliculas[i]);
        },
        itemCount: peliculas.length,
      ),
    );
  }

  Widget _crearTarjeta(BuildContext context,Pelicula p){
    final peliculaTarjeta =  Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: FadeInImage(
                image: NetworkImage(
                  p.getPosterImg(),
                ),
                placeholder: AssetImage(
                  'assets/img/no-image.jpg',
                ),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              p.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
      return GestureDetector(child: peliculaTarjeta, onTap: (){
        print('Pelicula titulo ${p.title}');
        Navigator.pushNamed(context, 'detalle',arguments: p);
      },);
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((p) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: FadeInImage(
                image: NetworkImage(
                  p.getPosterImg(),
                ),
                placeholder: AssetImage(
                  'assets/img/no-image.jpg',
                ),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              p.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
