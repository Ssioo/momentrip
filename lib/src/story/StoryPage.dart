import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentrip/src/travel/models/TravelResponse.dart';
import 'package:video_player/video_player.dart';

class StoryPage extends StatefulWidget {
  @override
  StoryState createState() => StoryState();
}

class StoryState extends State<StoryPage> {
  List<TravelResult> travelResultsInDay;

  VideoPlayerController videoPlayerController;
  VideoPlayerController nextPlayerController;
  int curVideoIdx = 0;
  bool _disposed = false;
  bool _isPlaying = false;
  bool _isEndPlaying = false;
  Future<void> _initVideo;

  @override
  void dispose() {
    _disposed = true;
    _initVideo = null;
    videoPlayerController?.pause()?.then((_) {
      videoPlayerController?.dispose();
    });
    nextPlayerController?.dispose();
    super.dispose();
  }

  Future<void> goNextVideo() async {
    if (videoPlayerController == null || _disposed) {
      return;
    }
    if (!videoPlayerController.value.initialized) {
      return;
    }
    final position = videoPlayerController.value.position;
    final duration = videoPlayerController.value.duration;
    final isPlaying = position.inSeconds < duration.inSeconds;
    final isEndPlaying =
        position.inMilliseconds > 0 && position.inSeconds == duration.inSeconds;

    if (isPlaying != _isPlaying || _isEndPlaying != isEndPlaying) {
      _isPlaying = isPlaying;
      _isEndPlaying = isEndPlaying;
      if (isEndPlaying) {
        final isComplete = curVideoIdx == travelResultsInDay.length - 1;
        if (isComplete) {
          Navigator.pop(context);
        } else {
          startVideo(curVideoIdx + 1);
        }
      }
    }
  }

  Future<bool> clearPrevVideo() async {
    await videoPlayerController?.pause();
    videoPlayerController?.removeListener(goNextVideo);
    return true;
  }

  Future<void> startVideo(int index) async {
    setState(() {
      _initVideo = null;
      curVideoIdx = index;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      clearPrevVideo().then((_) {
        initPlay(index);
      });
    });
  }

  Future<void> initPlay(int index) async {
    videoPlayerController = VideoPlayerController.network(
        travelResultsInDay.elementAt(index).videoUrl);
    videoPlayerController.addListener(goNextVideo);
    _initVideo = videoPlayerController.initialize();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      travelResultsInDay = ModalRoute.of(context).settings.arguments;
      startVideo(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          automaticallyImplyLeading: false,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: _initVideo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              videoPlayerController.play();
              return GestureDetector(
                onTapUp: (position) {
                  print(
                      "TAPUPTAPUPTAPUPTAPUPTAPUPTAPUPTAPUPTAPUPTAPUPTAPUPTAPUP");
                  if (videoPlayerController == null || _disposed) {
                    return;
                  }
                  if (!videoPlayerController.value.isPlaying) {
                    videoPlayerController.play();
                  }
                },
                onTapDown: (position) {
                  print(
                      "TAPDOWNTAPDOWNTAPDOWNTAPDOWNTAPDOWNTAPDOWNTAPDOWNTAPDOWNTAPDOWN");
                  if (videoPlayerController == null || _disposed) {
                    return;
                  }
                  if (videoPlayerController.value.isPlaying) {
                    videoPlayerController.pause();
                  }
                },
                child: Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 100),
                      child: Text(
                        travelResultsInDay.elementAt(curVideoIdx).address,
                        style: TextStyle(
                            fontFamily: "LemonMilk",
                            fontSize: 28,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 30, right: 30, bottom: 120),
                        child: Text(
                          travelResultsInDay.elementAt(curVideoIdx).videoText,
                          style: TextStyle(
                              fontFamily: "LemonMilk",
                              fontSize: 14,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  travelResultsInDay != null
                      ? CachedNetworkImage(
                          imageUrl: travelResultsInDay
                              .elementAt(curVideoIdx)
                              .thumbnailUrl,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.low,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.error_outline)),
                        )
                      : Container(),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            }
          },
        ));
  }
}
