import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPage extends StatefulWidget {
  @required
  final int videoID;
  final String movieName;
  TrailerPage(this.videoID, this.movieName);
  @override
  _TrailerPageState createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> {
  String videoURL = "https://www.youtube.com/watch?v=${"widget.ID.toString()"}";
  YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(initialVideoId: videoURL);
    print(widget.videoID);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieName),
        backgroundColor: Colors.red[800],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: widget.videoID != null
              ? YoutubePlayer(
                  controller: _controller,
                )
              : Text("No video found"),
        ),
      ),
    );
  }
}
