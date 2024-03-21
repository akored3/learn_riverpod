import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:learn_riverpod/example4.dart';

@immutable
class Movie {
  final String id;
  final String title;
  final String description;
  //can i do it like this?
  final bool? isFavorite;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    this.isFavorite,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['overview'],
    );
  }

  Movie copy({required bool isFavorite}) => Movie(
        id: id,
        title: title,
        description: description,
        isFavorite: isFavorite,
      );

  @override
  String toString() =>
      'Movie(id: $id, title: $title, description: $description, isFavorite: $isFavorite,)';

  @override
  bool operator ==(covariant Movie other) =>
      id == other.id && isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hashAll([
        id,
        isFavorite,
      ]);
}

Future<List<Movie>> fetchMovies() async {
  const apiKey = '393f26c7c95581d3f31b98aa37442411';
  const url =
      'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1?api_key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> results = jsonData['results'];

    return results.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

class MovieNotifier extends StateNotifier<List<Movie>> {
  MovieNotifier() : super([]);

  void loadMovies() async {
    try {
      final movies = await fetchMovies();
      state = movies;
    } catch (e) {
      print('Error fetching movies $e');
    }
  }

  void update(Movie movie, bool isFavorite) {
    state = state
        .map((thisMovie) => thisMovie.id == movie.id
            ? thisMovie.copy(isFavorite: isFavorite)
            : thisMovie)
        .toList();
  }
}

enum FavoriteMoviesStatus {
  all,
  favorite,
  notFavorite,
}

final allMoviesProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) => MovieNotifier());

final favoriteMoviesStatusProvider = Provider<FavoriteMoviesStatus>(
  (ref) => FavoriteMoviesStatus.all,
);

final notFavoriteMoviesStatus = Provider<Iterable<Movie>>((ref) => ref
    .watch(allMoviesProvider)
    .where((thisMovie) => thisMovie.isFavorite == false));

class HomePageFive extends ConsumerWidget {
  const HomePageFive({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Column(
        children: [
          MoviesList(
            providerX: allMoviesProvider,
          ),
        ],
      ),
    );
  }
}

class MoviesList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Movie>> providerX;
  const MoviesList({required this.providerX, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.read(providerX);
    return Expanded(
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies.elementAt(index);
          return ListTile(
            title: Text(movie.title),
          );
        },
      ),
    );
  }
}
