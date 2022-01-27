part of 'main_page_cubit.dart';

abstract class MainPageState {}

class MainPageEmpty extends MainPageState {}

class MainPageLoading extends MainPageState {}

class MainPageLoaded extends MainPageState {
  List<Movie> movies;
  MainPageLoaded({required this.movies});
}

class MainPageError extends MainPageState {
  String message;
  MainPageError({required this.message});
}
