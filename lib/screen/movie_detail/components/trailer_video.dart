import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerVideo extends StatefulWidget {
  final String trailerVideoUrl;

  const TrailerVideo({Key? key, required this.trailerVideoUrl})
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
        autoPlay: false,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
                bufferedColor: Colors.lightGreen,
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
    );
  }
}
