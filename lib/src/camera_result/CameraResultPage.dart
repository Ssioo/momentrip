import 'dart:io';
import 'dart:typed_data';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:momentrip/main.dart';
import 'package:momentrip/src/camera/CameraPage.dart';
import 'package:momentrip/src/camera_result/models/CameraResultParams.dart';
import 'package:momentrip/src/common/models/DefaultResponse.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CameraResultPage extends StatefulWidget {
  @override
  CameraResultState createState() => CameraResultState();
}

class CameraResultState extends State<CameraResultPage> {

  VideoPlayerController videoPlayerController;
  String filePath;
  int tripIdx;
  int day;
  Position position;
  String createdAt;
  Future<void> initVideo;
  File videoFile;
  String city;
  String country;
  String address;
  Uint8List thumbnailByte;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        CameraArgument argument = ModalRoute.of(context).settings.arguments;
        filePath = argument.filePath;
        tripIdx = argument.tripIdx;
        position = argument.position;
        day = argument.day;
        createdAt = argument.createdAt;
        videoFile = File(filePath);
        print(filePath);
        print(day);
        print(createdAt);
        videoPlayerController = VideoPlayerController.file(videoFile);
        initVideo = videoPlayerController.initialize();
        videoPlayerController.setLooping(true);
        trySearchLocation(position);
        getThumbnail();
      });
    });
  }

  Future<void> setPlayer() async {
    setState(() {
      videoPlayerController.play();
    });
  }

  void getThumbnail() async {
    thumbnailByte = await VideoThumbnail.thumbnailData(
      video: filePath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: MediaQuery.of(context).size.width.toInt(),
      quality: 100
    );
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255), size: 24),
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            FutureBuilder<void>(
              future: initVideo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  setPlayer();
                  return AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 115,
                child: Container(
                  color: Colors.black,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {

                        },
                        color: Colors.white,
                        iconSize: 24,
                      ),
                      IconButton(
                        icon: Icon(Icons.text_fields),
                        onPressed: () {

                        },
                        color: Colors.white,
                        iconSize: 24,
                      ),
                      IconButton(
                        icon: Icon(Icons.insert_emoticon),
                        onPressed: () {

                        },
                        color: Colors.white,
                        iconSize: 24,
                      ),
                      Expanded(
                        child: Container(

                        ),
                      ),
                      Parallelogram(
                        cutLength: 10.0,
                        child: SizedBox(
                          width: 60,
                          height: 50,
                          child: FlatButton(
                            child: Text(
                              "추가",
                              style: TextStyle(
                                fontFamily: "NotoSansKR",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white
                              ),
                            ),
                            padding: EdgeInsets.only(top: 6, bottom: 6),
                            color: Color.fromRGBO(255, 99, 62, 1),
                            onPressed: () {
                              // 업로드
                              tryUploadVideo(tripIdx, createdAt, position);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                //color: Colors.black,
                padding: EdgeInsets.only(bottom: 14, left: 20, right: 20, top: 100),
                child: InkWell(
                  child: Text(
                    address == null ? "" : address,
                    style: TextStyle(
                        fontFamily: "LemonMilk",
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 28,
                        color: Colors.white,
                      shadows: [Shadow(
                        blurRadius: 10.0,
                        color: Color.fromRGBO(24, 23, 23, 0.38),
                        offset: Offset(2.0, 2.0)
                      )]
                    ),
                  ),
                  onTap: () {
                    // place 선택
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void trySearchLocation(Position position) async {
    // By Geolocator Library
    List<Placemark> placeMarks = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: 'en');
    print(placeMarks.elementAt(0).toJson());
    setState(() {
      country = placeMarks.elementAt(0).country;
      city = placeMarks.elementAt(0).administrativeArea;
      address = placeMarks.elementAt(0).name + (placeMarks.elementAt(0).name == null ? "" : " ")
          + placeMarks.elementAt(0).thoroughfare + (placeMarks.elementAt(0).thoroughfare == null ? "" : ", ")
          + placeMarks.elementAt(0).subLocality + (placeMarks.elementAt(0).subLocality == null ? "" : " ")
          + placeMarks.elementAt(0).locality + (placeMarks.elementAt(0).locality == null ? "" : ", ")
          + placeMarks.elementAt(0).subAdministrativeArea;
    });
  }

  void tryUploadVideo(int tripIdx, String createdAt, Position position) async {
    ProgressDialog pr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    await pr.show();
    final FirebaseApp app = await FirebaseApp.configure(
        name: 'Momentrip',
        options: FirebaseOptions(
          googleAppID: Platform.isIOS ? '' : '1:376806552313:android:4f1721151cdf6c803ba828',
          gcmSenderID: '376806552313',
          apiKey: 'AIzaSyD_8X8izni4c9c8Q9qu-pCm8JtXM3mJBoE',
          projectID: 'momentrip-32cf2',
        )
    );
    final StorageReference storageReference = FirebaseStorage(app: app, storageBucket: 'gs://momentrip-32cf2.appspot.com').ref().child('userUploads');
    final StorageUploadTask uploadVideoTask = storageReference.child('$createdAt.mp4').putFile(videoFile);
    final StorageUploadTask uploadThumbTask = storageReference.child('$createdAt.jpg').putData(thumbnailByte);

    await uploadVideoTask.onComplete;
    await uploadThumbTask.onComplete;

    var downloadVideoUrl = await storageReference.child('$createdAt.mp4').getDownloadURL();
    var downloadThumbUrl = await storageReference.child('$createdAt.jpg').getDownloadURL();
    CameraResultParams params = CameraResultParams(
      categoryIdx: 1,
      videoUrl: downloadVideoUrl,
      thumbnail: downloadThumbUrl,
      tripImgUrl: downloadThumbUrl,
      videoText: 'Test',
      lat: position.latitude,
      lng: position.longitude,
      address: address,
      city: city,
      country: country,
      days: day,
    );
    print(params.toJson());
    Response response = await MyApp.getDio().post(
        'trip/$tripIdx', data: params.toJson());
    DefaultResponse defaultResponse = DefaultResponse.fromJson(response.data);
    await pr.hide();
    if (defaultResponse != null) {
      Navigator.pop(context, "Success");
      return;
    }
    setState(() {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          '여행 저장에 실패했습니다.',
          style: TextStyle(
            color: Color.fromRGBO(248, 248, 32, 1),
          ),
        ),
      ));
    });
  }
}