import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  @override
  CameraPageState createState() => CameraPageState();

}

class CameraPageState extends State<CameraPage> {

  CameraController cameraController;
  List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    setCamera();
  }

  Future<void> setCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 100,
          child: Transform.scale(
            scale: cameraController.value.aspectRatio / MediaQuery.of(context).size.aspectRatio,
            child: AspectRatio(
              aspectRatio: cameraController.value.aspectRatio,
              child: CameraPreview(cameraController),
            ),
          ),
        ),
      ),
    );
  }

}