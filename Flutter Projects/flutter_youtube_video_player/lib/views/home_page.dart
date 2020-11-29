import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  YoutubePlayerController _youtubePlayerController;
  String videoUrl = 'https://www.youtube.com/watch?v=Be9UH1kXFDw';
  @override
  void initState()
  {
    _youtubePlayerController = YoutubePlayerController
    (
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl),
      flags: YoutubePlayerFlags
      (
        autoPlay: true,
        loop: true,
       // isLive: true
      )

    );
    super.initState();
  }

  @override 
  Widget build(BuildContext context)
  {
    return Scaffold
    (
       appBar: AppBar
       (
         title: Text(widget.title),
         centerTitle: true,
       ),

       body: SingleChildScrollView
       (
         child: Container
         (
           child: Column
           (
             children: <Widget>
             [
               YoutubePlayer
               (
                 controller: _youtubePlayerController
               )
             ],
           ),
         ),
       ),
    );
  }
  
}
