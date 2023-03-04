import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_cast_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie_detail/components/cast_movie_card.dart';

class CastMovieScreen extends StatefulWidget {
  final List<MovieCastModel> casts;

  const CastMovieScreen({Key? key, required this.casts}) : super(key: key);

  @override
  State<CastMovieScreen> createState() => _CastMovieScreenState();
}

class _CastMovieScreenState extends State<CastMovieScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Dàn diễn viên',
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge!.color,
                  fontSize: getProportionateScreenWidth(32),
                  fontWeight: FontWeight.bold,
                )),
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
            ),
          ),
          // extendBodyBehindAppBar: true,
          body: Container(
            color: Theme.of(context).colorScheme.background,
            alignment: Alignment.topCenter,
            child: Container(
              width: SizeConfig.screenWidth * 0.9,
              height: SizeConfig.screenHeight,
              margin: const EdgeInsets.only(top: 10),
              child: ListView(
                children: List.generate(widget.casts.length, (index) {
                  return CastMovieCard(cast: widget.casts[index]);
                }),
              ),
            ),
          )),
    );
  }
}
