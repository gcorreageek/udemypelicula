 
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proy_udemy_peliculas/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = "a635cc45dd90d62e402fc8a7a22c806a";
  String _url = "api.themoviedb.org";
  String _lenguaje = "es-ES";

  int _popularesPage = 1;
  bool _cargando = false;
  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;


  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _lenguaje,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if(_cargando) return [];
    _cargando = true;
    _popularesPage++;
    print('Cargando...');
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _lenguaje,
      'page': _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }
}
