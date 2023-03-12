import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_cast_model.dart';

class MovieModel {
  int id;
  String name;
  List<String> genres;
  double rating;
  String director;
  String production;
  int duration;
  String storyLine;
  String trailerVideoUrl;
  Image image;
  Image imageDesktop;
  Image imageLogo;
  List<MovieCastModel> castList;

  MovieModel({
    required this.id,
    required this.genres,
    required this.name,
    required this.rating,
    required this.director,
    required this.production,
    required this.duration,
    required this.storyLine,
    required this.trailerVideoUrl,
    required this.image,
    required this.imageDesktop,
    required this.imageLogo,
    required this.castList,
  });
}

var movies = [
  MovieModel(
      id: 1,
      name: 'Togo',
      rating: 8.0,
      genres: [
        "Drama",
      ],
      director: 'Ericson Core',
      duration: 114,
      storyLine:
          'Togo (1913 – December 5, 1929) was the lead sled dog of Leonhard Seppala and his dog sled team in the 1925 serum run to Nome across central and northern Alaska. Even though he covered more distance (260 miles) than his co-sledder Balto (55 miles), he didn\'t get as much fame.',
      trailerVideoUrl: 'https://www.youtube.com/watch?v=HMfyueM-ZBQ',
      image: Image.asset("assets/image/togo.jpeg", height: 200, width: 150),
      imageDesktop: Image.asset("assets/image/togo_desktop.jpg"),
      imageLogo: Image.asset("assets/image/togologo.png"),
      castList: [
        MovieCastModel(
          name: "Willem Dafoe",
          photo: Image.asset("assets/image/cast/willem.jpg"),
        ),
        MovieCastModel(
          name: "Julianne Nicholson",
          photo: Image.asset("assets/image/cast/julianne.jpg"),
        ),
        MovieCastModel(
          name: "Christopher Heyerdahl",
          photo: Image.asset("assets/image/cast/christopher.jpg"),
        ),
        MovieCastModel(
          name: "Nicolai Nikolaeff",
          photo: Image.asset("assets/image/cast/nicolai.jpg"),
        ),
        MovieCastModel(
          name: "Michael McElhatton",
          photo: Image.asset("assets/image/cast/michael.jpg"),
        )
      ], production: 'Walt Disney Pictures'),
  MovieModel(
      id: 2,
      name: 'Joker',
      rating: 8.5,
      genres: ["Tội phạm", "Drama"],
      director: 'Todd Phillips',
      duration: 122,
      storyLine:
          "Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like he's part of the world around him. Isolated, bullied and disregarded by society, Fleck begins a slow descent into madness as he transforms into the criminal mastermind known as the Joker.",
      trailerVideoUrl: 'https://www.youtube.com/watch?v=zAGVQLHvwOY',
      image: Image.asset("assets/image/joker.jpeg", height: 200, width: 150),
      imageDesktop: Image.asset("assets/image/joker_desktop.jpg"),
      imageLogo: Image.asset("assets/image/jokerlogo.png"),
      castList: [
        MovieCastModel(
          name: "Joaquin Phoenix",
          photo: Image.asset("assets/image/cast/joaquin.jpg"),
        ),
        MovieCastModel(
          name: "Robert De Niro",
          photo: Image.asset("assets/image/cast/niro.jpg"),
        ),
        MovieCastModel(
          name: "Zazie Beetz",
          photo: Image.asset("assets/image/cast/zazie.jpg"),
        ),
        MovieCastModel(
          name: 'Glen Fleshler',
          photo: Image.asset("assets/image/cast/glen.jpg"),
        ),
        MovieCastModel(
          name: "Frances Conroy",
          photo: Image.asset("assets/image/cast/frances.jpg"),
        ),
        MovieCastModel(
          name: "Dante Pereira-Olson",
          photo: Image.asset("assets/image/cast/dante.jpg"),
        ),
      ], production: 'Warner Bros. Pictures'),
  MovieModel(
      id: 3,
      name: 'Planet of the Apes',
      rating: 5.7,
      genres: ["Hành động", "Adventure", "Fantasy"],
      director: 'Tim Burton',
      duration: 131,
      storyLine:
          "Complex sociological themes run through this science-fiction classic about three astronauts marooned on a futuristic planet where apes rule and humans are slaves. The stunned trio discovers that these highly intellectual simians can both walk upright and talk. They have even established a class system and a political structure. The astronauts suddenly find themselves part of a devalued species, trapped and imprisoned by the apes.",
      trailerVideoUrl: 'https://www.youtube.com/watch?v=qxjPjPzQ1iU',
      image: Image.asset("assets/image/apes.jpeg", height: 200, width: 150),
      imageDesktop: Image.asset("assets/image/apes_desktop.jpg"),
      imageLogo: Image.asset("assets/image/apeslogo.png"),
      castList: [
        MovieCastModel(
          name: "Cornelius",
          photo: Image.asset("assets/image/cast/cornelius.jpg"),
        ),
        MovieCastModel(
          name: "Dr. Zaius",
          photo: Image.asset("assets/image/cast/zaius.jpg"),
        ),
        MovieCastModel(
          name: "Dr. Zira",
          photo: Image.asset("assets/image/cast/zira.jpg"),
        ),
        MovieCastModel(
          name: "Nova",
          photo: Image.asset("assets/image/cast/nova.jpg"),
        ),
        MovieCastModel(
          name: "Nova",
          photo: Image.asset("assets/image/cast/nova.jpg"),
        ),
      ], production: '20th Century Fox'),
  MovieModel(
      id: 4,
      name: 'Togo',
      rating: 8.0,
      genres: [
        "Drama",
      ],
      director: 'Ericson Core',
      duration: 114,
      storyLine:
          'Togo (1913 – December 5, 1929) was the lead sled dog of Leonhard Seppala and his dog sled team in the 1925 serum run to Nome across central and northern Alaska. Even though he covered more distance (260 miles) than his co-sledder Balto (55 miles), he didn\'t get as much fame.',
      trailerVideoUrl: 'https://www.youtube.com/watch?v=HMfyueM-ZBQ',
      image: Image.asset("assets/image/togo.jpeg", height: 200, width: 150),
      imageDesktop: Image.asset("assets/image/togo_desktop.jpg"),
      imageLogo: Image.asset("assets/image/togologo.png"),
      castList: [
        MovieCastModel(
          name: "Willem Dafoe",
          photo: Image.asset("assets/image/cast/willem.jpg"),
        ),
        MovieCastModel(
          name: "Julianne Nicholson",
          photo: Image.asset("assets/image/cast/julianne.jpg"),
        ),
        MovieCastModel(
          name: "Christopher Heyerdahl",
          photo: Image.asset("assets/image/cast/christopher.jpg"),
        ),
        MovieCastModel(
          name: "Nicolai Nikolaeff",
          photo: Image.asset("assets/image/cast/nicolai.jpg"),
        ),
        MovieCastModel(
          name: "Michael McElhatton",
          photo: Image.asset("assets/image/cast/michael.jpg"),
        )
      ], production: '20th Century Fox'),
  MovieModel(
      id: 5,
      name: 'Joker',
      rating: 8.5,
      genres: ["Crime", "Drama"],
      director: 'Todd Phillips',
      duration: 122,
      storyLine:
          "Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like he's part of the world around him. Isolated, bullied and disregarded by society, Fleck begins a slow descent into madness as he transforms into the criminal mastermind known as the Joker.",
      trailerVideoUrl: 'https://www.youtube.com/watch?v=zAGVQLHvwOY',
      image: Image.asset("assets/image/joker.jpeg", height: 200, width: 150),
      imageDesktop: Image.asset("assets/image/joker_desktop.jpg"),
      imageLogo: Image.asset("assets/image/jokerlogo.png"),
      castList: [
        MovieCastModel(
          name: "Joaquin Phoenix",
          photo: Image.asset("assets/image/cast/joaquin.jpg"),
        ),
        MovieCastModel(
          name: "Robert De Niro",
          photo: Image.asset("assets/image/cast/niro.jpg"),
        ),
        MovieCastModel(
          name: "Zazie Beetz",
          photo: Image.asset("assets/image/cast/zazie.jpg"),
        ),
        MovieCastModel(
          name: 'Glen Fleshler',
          photo: Image.asset("assets/image/cast/glen.jpg"),
        ),
        MovieCastModel(
          name: "Frances Conroy",
          photo: Image.asset("assets/image/cast/frances.jpg"),
        ),
        MovieCastModel(
          name: "Dante Pereira-Olson",
          photo: Image.asset("assets/image/cast/dante.jpg"),
        ),
      ], production: 'Warner Bros. Pictures'),
  MovieModel(
      id: 6,
      name: 'Planet of the Apes',
      rating: 5.7,
      genres: ["Action", "Adventure", "Fantasy"],
      director: 'Tim Burton',
      duration: 131,
      storyLine:
          "Complex sociological themes run through this science-fiction classic about three astronauts marooned on a futuristic planet where apes rule and humans are slaves. The stunned trio discovers that these highly intellectual simians can both walk upright and talk. They have even established a class system and a political structure. The astronauts suddenly find themselves part of a devalued species, trapped and imprisoned by the apes.",
      trailerVideoUrl: 'https://www.youtube.com/watch?v=qxjPjPzQ1iU',
      image: Image.asset("assets/image/apes.jpeg", height: 200, width: 150),
      imageDesktop: Image.asset("assets/image/apes_desktop.jpg"),
      imageLogo: Image.asset("assets/image/apeslogo.png"),
      castList: [
        MovieCastModel(
          name: "Cornelius",
          photo: Image.asset("assets/image/cast/cornelius.jpg"),
        ),
        MovieCastModel(
          name: "Dr. Zaius",
          photo: Image.asset("assets/image/cast/zaius.jpg"),
        ),
        MovieCastModel(
          name: "Dr. Zira",
          photo: Image.asset("assets/image/cast/zira.jpg"),
        ),
        MovieCastModel(
          name: "Nova",
          photo: Image.asset("assets/image/cast/nova.jpg"),
        ),
        MovieCastModel(
          name: "Nova",
          photo: Image.asset("assets/image/cast/nova.jpg"),
        ),
      ], production: '20th Century Fox'),
  MovieModel(
      id: 7,
      name: 'Togo',
      rating: 8.0,
      genres: [
        "Drama",
      ],
      director: 'Ericson Core',
      duration: 114,
      storyLine:
          'Togo (1913 – December 5, 1929) was the lead sled dog of Leonhard Seppala and his dog sled team in the 1925 serum run to Nome across central and northern Alaska. Even though he covered more distance (260 miles) than his co-sledder Balto (55 miles), he didn\'t get as much fame.',
      trailerVideoUrl: 'https://www.youtube.com/watch?v=HMfyueM-ZBQ',
      image: Image.asset("assets/image/togo.jpeg", height: 200, width: 150),
      imageDesktop: Image.asset("assets/image/togo_desktop.jpg"),
      imageLogo: Image.asset("assets/image/togologo.png"),
      castList: [
        MovieCastModel(
          name: "Willem Dafoe",
          photo: Image.asset("assets/image/cast/willem.jpg"),
        ),
        MovieCastModel(
          name: "Julianne Nicholson",
          photo: Image.asset("assets/image/cast/julianne.jpg"),
        ),
        MovieCastModel(
          name: "Christopher Heyerdahl",
          photo: Image.asset("assets/image/cast/christopher.jpg"),
        ),
        MovieCastModel(
          name: "Nicolai Nikolaeff",
          photo: Image.asset("assets/image/cast/nicolai.jpg"),
        ),
        MovieCastModel(
          name: "Michael McElhatton",
          photo: Image.asset("assets/image/cast/michael.jpg"),
        )
      ], production: '20th Century Fox'),
  MovieModel(
      id: 8,
      name: 'Joker',
      rating: 8.5,
      genres: ["Crime", "Drama"],
      director: 'Todd Phillips',
      duration: 122,
      storyLine:
          "Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like he's part of the world around him. Isolated, bullied and disregarded by society, Fleck begins a slow descent into madness as he transforms into the criminal mastermind known as the Joker.",
      trailerVideoUrl: 'https://www.youtube.com/watch?v=zAGVQLHvwOY',
      image: Image.asset("assets/image/joker.jpeg", height: 200, width: 150),
      imageDesktop: Image.asset("assets/image/joker_desktop.jpg"),
      imageLogo: Image.asset("assets/image/jokerlogo.png"),
      castList: [
        MovieCastModel(
          name: "Joaquin Phoenix",
          photo: Image.asset("assets/image/cast/joaquin.jpg"),
        ),
        MovieCastModel(
          name: "Robert De Niro",
          photo: Image.asset("assets/image/cast/niro.jpg"),
        ),
        MovieCastModel(
          name: "Zazie Beetz",
          photo: Image.asset("assets/image/cast/zazie.jpg"),
        ),
        MovieCastModel(
          name: 'Glen Fleshler',
          photo: Image.asset("assets/image/cast/glen.jpg"),
        ),
        MovieCastModel(
          name: "Frances Conroy",
          photo: Image.asset("assets/image/cast/frances.jpg"),
        ),
        MovieCastModel(
          name: "Dante Pereira-Olson",
          photo: Image.asset("assets/image/cast/dante.jpg"),
        ),
      ], production: 'Warner Bros. Pictures'),
  MovieModel(
      id: 9,
      name: 'Planet of the Apes',
      rating: 5.7,
      genres: ["Action", "Adventure", "Fantasy"],
      director: 'Tim Burton',
      duration: 131,
      storyLine:
          "Complex sociological themes run through this science-fiction classic about three astronauts marooned on a futuristic planet where apes rule and humans are slaves. The stunned trio discovers that these highly intellectual simians can both walk upright and talk. They have even established a class system and a political structure. The astronauts suddenly find themselves part of a devalued species, trapped and imprisoned by the apes.",
      trailerVideoUrl: 'https://www.youtube.com/watch?v=qxjPjPzQ1iU',
      image: Image.asset("assets/image/apes.jpeg", height: 200, width: 150),
      imageDesktop: Image.asset("assets/image/apes_desktop.jpg"),
      imageLogo: Image.asset("assets/image/apeslogo.png"),
      castList: [
        MovieCastModel(
          name: "Cornelius",
          photo: Image.asset("assets/image/cast/cornelius.jpg"),
        ),
        MovieCastModel(
          name: "Dr. Zaius",
          photo: Image.asset("assets/image/cast/zaius.jpg"),
        ),
        MovieCastModel(
          name: "Dr. Zira",
          photo: Image.asset("assets/image/cast/zira.jpg"),
        ),
        MovieCastModel(
          name: "Nova",
          photo: Image.asset("assets/image/cast/nova.jpg"),
        ),
        MovieCastModel(
          name: "Nova",
          photo: Image.asset("assets/image/cast/nova.jpg"),
        ),
      ], production: ''),
];
