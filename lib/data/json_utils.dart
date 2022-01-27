import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'model/movie.dart';
import 'network_helper.dart';

class JsonUtils {
  final String _baseUrl = 'https://api.themoviedb.org/3/discover/movie';
  final String _apikey = '4e1808f48673a589b0697bd4184f1edc';
  final String language = 'En-en';
//обработка данных из кэша
  Future<List<Movie>> getMoviesFromCache() async{
    String fileName = 'pathString.json';
    var dir = await getTemporaryDirectory();
    File file = File('${dir.path}/$fileName');
    List<Movie> movies = [];
    if(file.existsSync()){
      log('reading from cache');
      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      final Iterable results = await res['results'] as Iterable;
      movies = results.map((movie) => Movie.fromJson(movie as Map<String, dynamic>)).toList();
    }
    return movies;
  }

//обработка данных из интернета
  Future<List<Movie>> getMovies(int page) async {
    final NetworkHelper networkHelper = NetworkHelper(
      '$_baseUrl?api_key=$_apikey&language=$language&page=$page',
    );
    var data = await networkHelper.getData();
    final Iterable results = await data['results'] as Iterable;
    List<Movie> movies = results.map((movie) => Movie.fromJson(movie as Map<String, dynamic>)).toList();
    List<Movie> movies2 = [];
    for(int i = 0; i<10; i++){
      movies2.add(movies[i]);
    }
    return movies;
  }
}