import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/data/json_utils.dart';
import 'package:newsapp/data/model/movie.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(MainPageEmpty());
  int _currentPage = 1;
  List<Movie> _movies = [];

  Future<void> onRefresh() async {
    try {
      emit(MainPageLoading());
      _currentPage = 1;
      final data = await JsonUtils().getMovies(_currentPage);
      log('DATA::: $data');
      log("REFRESHING:: , page:: $_currentPage");
      log('Movies::: $_movies');
      _movies = data;
      _currentPage++;
      emit(MainPageLoaded(movies: _movies));
    } catch (e) {
      final data = await JsonUtils().getMoviesFromCache();
      if (data.isNotEmpty) {
        _movies = data;
        emit(MainPageLoaded(movies: _movies));
      }else{
        emit(MainPageError(message: '$e'));
      }
    }
  }

  Future<void> onLoading() async {
    try {
      final data = await JsonUtils().getMovies(_currentPage);
      _currentPage++;
      log("ONLOADING:: , page:: $_currentPage");
      _movies.addAll(data);
      emit(MainPageLoaded(movies: _movies));
    } catch (e) {
      final data = await JsonUtils().getMoviesFromCache();
    if (data.isNotEmpty) {
      _movies = data;
      emit(MainPageLoaded(movies: _movies));
    }else{
      emit(MainPageError(message: '$e'));
    }
    }
  }
}
