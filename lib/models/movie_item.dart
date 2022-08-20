// ignore_for_file: non_constant_identifier_names

class MovieItem {
  int id;
  double vote_average;

  String original_title;
  String overview;
  String poster_path;
  MovieItem({
    required this.id,
    required this.vote_average,
    required this.original_title,
    required this.overview,
    required this.poster_path,
  });

  factory MovieItem.fromMap(Map<String, dynamic> map) {
    return MovieItem(
      id: map['id']?.toInt(),
      vote_average: map['vote_average'],
      original_title: map['original_title'],
      overview: map['overview'],
      poster_path: map['poster_path'],
    );
  }
}
