import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerVideo extends StatefulWidget {
  final String trailerVideoUrl;
  final Uint8List? thumbnail;

  const TrailerVideo(
      {Key? key, required this.trailerVideoUrl, required this.thumbnail})
      : super(key: key);

  @override
  State<TrailerVideo> createState() => _TrailerVideoState();
}

class _TrailerVideoState extends State<TrailerVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.trailerVideoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          disableDragSeek: true,
          loop: false,
          enableCaption: false),
    );
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          onReady: () {
            print('Player is ready.');
          },
          thumbnail: Center(
              // Image movie poster
              child: Image(
            image: Image.memory(widget.thumbnail!).image,
          )),
          controller: _controller,
          showVideoProgressIndicator: true,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
                isExpanded: true,
                colors: ProgressBarColors(
                  playedColor: Theme.of(context).primaryColor,
                  handleColor: Theme.of(context).primaryColor,
                  bufferedColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.grey,
                )),
            RemainingDuration(),
            FullScreenButton(),
            const PlaybackSpeedButton(),
          ],
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
            ],
          );
        },
      ),
    );
  }
}
