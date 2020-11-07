import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_app/Services/MovieApi.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPage extends StatefulWidget {
  @required
  final int videoID;
  final String movieName;
  final String moviePoster;
  TrailerPage(this.videoID, this.movieName, this.moviePoster);
  @override
  _TrailerPageState createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> {
  YoutubePlayerController _controller;
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.4), BlendMode.dstATop),
        image: NetworkImage(widget.moviePoster),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: FutureBuilder(
            future: Provider.of<MovieApi>(context, listen: false)
                .fetchTrailerId(widget.videoID.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.yellow[800]),
                );
              }
              _controller = YoutubePlayerController(
                  initialVideoId: snapshot.data,
                  flags: YoutubePlayerFlags(autoPlay: true, mute: false));
              return Container(
                  child: YoutubePlayer(
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.yellow[800],
                controller: _controller,
              ));
            },
          ),
        ),
      ),
    );
  }
}
