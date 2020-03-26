import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geo;
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart'
as PermissionHandler;

import '../travel/TravelPage.dart';

class CameraPage extends StatefulWidget {
  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> with WidgetsBindingObserver {

  CameraController cameraController;
  List<CameraDescription> cameras;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var cameraIcon = Icons.videocam;
  var recordedTime = 0.0;
  int tripIdx;
  int day;
  Geo.Position position;
  Timer recordTimer;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        TravelArgument argument = ModalRoute.of(context).settings.arguments;
        tripIdx = argument.tripIdx;
        position = argument.position;
        day = argument.day;
      });
    });
    WidgetsBinding.instance.addObserver(this);
    setCamera();
  }

  Future<void> setCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.veryHigh);
    await cameraController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    cameraController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      setCamera();
      setState(() {
        recordedTime = 0.0;
      });
    } else if (state == AppLifecycleState.paused) {
      setState(() {
        recordedTime = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Scaffold();
    }
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.black,
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              AspectRatio(
                aspectRatio: cameraController.value.aspectRatio,
                child: CameraPreview(cameraController),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 115,
                  child: Container(
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MaterialButton(
                          child: Text(
                            "취소",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 14,
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w300),
                          ),
                          shape: CircleBorder(side: BorderSide.none),
                          padding: EdgeInsets.all(12),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                value: recordedTime / 30.0,
                              ),
                            ),
                            MaterialButton(
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                cameraIcon,
                                color: Colors.black,
                                size: 32,
                              ),
                              shape: CircleBorder(side: BorderSide.none),
                              color: Colors.white,
                              onPressed: () {
                                onVideoRecordButtonPressed(context);
                              },
                            ),
                          ],
                        ),
                        MaterialButton(
                            child: Icon(
                              Icons.refresh,
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              size: 32,
                            ),
                            padding: EdgeInsets.all(12),
                            shape: CircleBorder(side: BorderSide.none),
                            color: Color.fromRGBO(28, 28, 28, 1),
                            onPressed: onCameraSwitch)
                      ],
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }

  void onCameraSwitch() async {
    if (cameraController.value.isRecordingVideo) {
      return;
    }
    final CameraDescription cameraDescription =
    cameraController.description == cameras[0] ? cameras[1] : cameras[0];
    if (cameraController != null) {
      await cameraController.dispose();
    }
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.veryHigh);
    cameraController.addListener(() {
      if (mounted) setState(() {
        recordedTime = 0.0;
      });
      if (cameraController.value.hasError) {}
    });
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      showInSnackBar("CAMERA ERROR with " + e.code);
    }
    if (mounted) setState(() {});
  }

  String videoFilePath;

  void onVideoRecordButtonPressed(BuildContext context) async {
    if (cameraController.value.isRecordingVideo) {
      await stopVideoRecording(context);
      setState(() {
        cameraIcon = Icons.videocam;
      });
      return null;
    }
    setState(() {
      cameraIcon = Icons.stop;
    });
    String filePath = await startVideoRecording(context);
    if (mounted) {
      setState(() {});
    }
    if (filePath != null) {
      setState(() {
        videoFilePath = filePath;
      });
    }
  }

  Future<bool> requestStoragePermisson() async {
    PermissionHandler.PermissionHandler permissionHandler =
    PermissionHandler.PermissionHandler();
    List<PermissionHandler.PermissionGroup> permissionGroup = List();
    bool checkedStorage = await permissionHandler
        .checkPermissionStatus(PermissionHandler.PermissionGroup.storage) !=
        PermissionHandler.PermissionStatus.granted;
    bool checkedLocation = await permissionHandler.checkPermissionStatus(
        PermissionHandler.PermissionGroup.locationWhenInUse) !=
        PermissionHandler.PermissionStatus.granted;
    bool checkedCamera = await permissionHandler
        .checkPermissionStatus(PermissionHandler.PermissionGroup.camera) !=
        PermissionHandler.PermissionStatus.granted;
    bool checkedPhotos = await permissionHandler
        .checkPermissionStatus(PermissionHandler.PermissionGroup.photos) !=
        PermissionHandler.PermissionStatus.granted;
    bool checkedMedia = await permissionHandler.checkPermissionStatus(
        PermissionHandler.PermissionGroup.accessMediaLocation) !=
        PermissionHandler.PermissionStatus.granted;
    if (checkedStorage) {
      permissionGroup.add(PermissionHandler.PermissionGroup.storage);
    }
    if (checkedLocation) {
      permissionGroup.add(PermissionHandler.PermissionGroup.locationWhenInUse);
    }
    if (checkedCamera) {
      permissionGroup.add(PermissionHandler.PermissionGroup.camera);
    }
    if (checkedPhotos) {
      permissionGroup.add(PermissionHandler.PermissionGroup.photos);
    }
    if (checkedMedia) {
      permissionGroup
          .add(PermissionHandler.PermissionGroup.accessMediaLocation);
    }
    if (permissionGroup.length > 0) {
      var permitted =
      await permissionHandler.requestPermissions(permissionGroup);
      bool checked = true;
      for (PermissionHandler.PermissionGroup permission in permissionGroup) {
        if (permitted[permission] == PermissionHandler.PermissionStatus.denied || permitted[permission] == PermissionHandler.PermissionStatus.neverAskAgain) {
          checked = false;
          break;
        }
      }
      return checked;
    }
    return true;
  }

  Future<String> startVideoRecording(BuildContext context) async {
    if (!cameraController.value.isInitialized) {
      showInSnackBar("CAMERA ERROR");
      return null;
    }
    bool permitted = await requestStoragePermisson();
    if (!permitted) {
      Navigator.pop(context);
      return null;
    }
    final extDir = await getExternalCacheDirectories();

    await Directory(extDir.elementAt(0).path + "/Momentrip").create(recursive: true);
    final filePath = Path.join(extDir.elementAt(0).path, 'Momentrip', '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4');
    print("FilePath: " + filePath);
    try {
      await cameraController.startVideoRecording(filePath);
      recordTimer = Timer.periodic(
          Duration(milliseconds: 100), (timer) {
            setState(() {
              recordedTime += 0.1;
            });
            if (recordedTime == 30) {
              stopVideoRecording(context);
            }
          }
      );
    } on CameraException catch (e) {
      showInSnackBar("CAMERA ERROR WITH " + e.code);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording(BuildContext context) async {
    recordTimer.cancel();
    if (!cameraController.value.isRecordingVideo) {
      showInSnackBar("CAMERA ERROR");
      return null;
    }

    try {
      double recordedTimePass = recordedTime;
      await cameraController.stopVideoRecording();
      setState(() {
        recordedTime = 0.0;
      });
      dynamic result = await Navigator.pushNamed(context, "/camera/result",
          arguments: CameraArgument(
              tripIdx: tripIdx,
              filePath: videoFilePath,
              time: recordedTimePass,
              position: position,
              day: day,
              createdAt: videoFilePath.substring(
                  videoFilePath.lastIndexOf('/') + 1,
                  videoFilePath.lastIndexOf('.'))));
      if (result == "Success") {
        Navigator.pop(context, "Success");
      }
    } on CameraException catch (e) {
      showInSnackBar("CAMERA ERROR WITH " + e.code);
      return null;
    }
  }

  void showInSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Color.fromRGBO(248, 248, 32, 1),
          fontFamily: "NotoSansKR",
          fontWeight: FontWeight.w300,
        ),
      ),
    ));
  }
}

class CameraArgument {
  int tripIdx;
  String filePath;
  double time;
  Geo.Position position;
  String createdAt;
  int day;

  CameraArgument(
      {this.tripIdx, this.filePath, this.time, this.position, this.createdAt, this.day});

}
