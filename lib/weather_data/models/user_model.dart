import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.results,
  });

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      results: (json['results'] as List<dynamic>? ?? []).map(
        (e) {
          return Results.fromJson(e);
        },
      ).toList(),
    );
  }

  final List<Results> results;

  @override
  List<Object?> get props => [results];
}

class Results {
  Results({
    required this.name,
    required this.email,
    required this.picture,
  });

  factory Results.fromJson(dynamic json) {
    return Results(
      email: json['email'] as String? ?? '',
      name: Name.fromJson(json['name']),
      picture: Picture.fromJson(json['picture']),
    );
  }

  final Name name;
  final String email;
  final Picture picture;
}

class Picture {
  Picture({
    this.large,
    this.medium,
    this.thumbnail,
  });

  factory Picture.fromJson(dynamic json) {
    final large = json['large'] as String? ?? '';
    final medium = json['medium'] as String? ?? '';
    final thumbnail = json['thumbnail'] as String? ?? '';
    return Picture(thumbnail: thumbnail, large: large, medium: medium);
  }

  final String? large;
  final String? medium;
  final String? thumbnail;
}

class Name {
  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromJson(dynamic json) {
    final title = json['title'] as String? ?? '';
    final first = json['first'] as String? ?? '';
    final last = json['last'] as String? ?? '';
    return Name(
      title: title,
      last: last,
      first: first,
    );
  }

  final String title;
  final String first;
  final String last;
}
