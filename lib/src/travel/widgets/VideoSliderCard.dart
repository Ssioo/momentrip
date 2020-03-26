import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprintf/sprintf.dart';
import 'package:video_player/video_player.dart';

class VideoSliderCard extends StatefulWidget {
  final int idx;
  final String title;
  final String videoUrl;
  final String thumbnailUrl;

  VideoSliderCard(
      {Key key, this.idx, this.title, this.videoUrl, this.thumbnailUrl})
      : super(key: key);

  @override
  VideoSliderState createState() =>
      VideoSliderState(idx, title, videoUrl, thumbnailUrl);
}

class VideoSliderState extends State<VideoSliderCard> {
  VideoPlayerController videoPlayerController;

  final int idx;
  final String title;
  final String videoUrl;
  final String thumbnailUrl;

  VideoSliderState(this.idx, this.title, this.videoUrl, this.thumbnailUrl);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) {
        setState(() {
          videoPlayerController.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (videoPlayerController.value.initialized) {
          if (!videoPlayerController.value.isPlaying) {
            videoPlayerController.play();
          } else {
            videoPlayerController.pause();
          }
        }
      },
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: videoPlayerController.value.initialized
                  ? AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    )
                  : CachedNetworkImage(
                      imageUrl: thumbnailUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, _) => Center(
                        child: Icon(Icons.error_outline),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 23, top: 23, right: 23),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: "LemonMilk",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 23, bottom: 23),
                child: Text(
                  getDuration(videoPlayerController),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    fontFamily: "LemonMilk",
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getDuration(VideoPlayerController videoPlayerController) {
    if (videoPlayerController.value.initialized) {
      Duration duration = videoPlayerController.value.duration;
      int seconds = duration.inSeconds;

      return sprintf('%02d', [seconds ~/ 60]) +
          ":" +
          sprintf('%02d', [seconds.remainder(60)]);
    } else {
      return "--:--";
    }
  }
}
