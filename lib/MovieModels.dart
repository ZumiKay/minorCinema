import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieList {
  int? page;
  int? totalMovies;
  int? totalPages;
  List<Moviedata>? movies;

  MovieList(this.page, this.totalMovies, this.totalPages, this.movies);
  MovieList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalMovies = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      movies = [];
      json['results'].forEach((data) {
        movies!.add(Moviedata.fromJson(data));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['total_results'] = page;
    data['total_pages'] = page;
    if (movies != null) {
      data['results'] = movies!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Moviedata {
  int? id;
  String? title;
  String? release_date;
  String? posterPath;
  List<String>? time;

  Moviedata(this.id, this.posterPath, this.release_date, this.title);
  Moviedata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    release_date = json['release_date'];
    posterPath = json['poster_path'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['release_date'] = release_date;
    data['poster_path'] = posterPath;

    return data;
  }
}

Future<List<Moviedata>> fetchMovie (String api) async {
  MovieList movielist;
  var res = await http.get(Uri.parse(api));
  var decoderes = jsonDecode(res.body);
  movielist = MovieList.fromJson(decoderes);
  return movielist.movies ?? []; 
}
