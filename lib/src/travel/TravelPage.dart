import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class TravelPage extends StatefulWidget {
  @override
  TravelPageState createState() => TravelPageState();
}

class TravelPageState extends State<TravelPage> {
  MapboxMapController mapController;

  Location userLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController.removeListener(_onMapChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        actionsIconTheme:
            IconThemeData(color: Color.fromARGB(255, 255, 255, 255), size: 24),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (context, index) {
              
            },
            scrollDirection: Axis.horizontal,
          ),
          MapboxMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(37.555033, 126.970904), zoom: 13),
            onMapCreated: (controller) {
              mapController = controller;
              mapController.addListener(_onMapChanged);
            },
            styleString: MapboxStyles.DARK,
            myLocationTrackingMode: MyLocationTrackingMode.Tracking,
            trackCameraPosition: true,
            compassEnabled: true,
            myLocationRenderMode: MyLocationRenderMode.GPS,
          ),
        ],
      ),
    );
  }

  void _onMapChanged() {
    setState(() {});
  }
}
