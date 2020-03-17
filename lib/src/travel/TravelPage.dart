
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geo;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:momentrip/src/travel/widgets/CircularStoryWidget.dart';

class TravelPage extends StatefulWidget {
  @override
  TravelPageState createState() => TravelPageState();
}

class TravelPageState extends State<TravelPage> {
  MapboxMapController mapController;
  int tripIdx;
  Geo.Position position;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      tripIdx = ModalRoute.of(context).settings.arguments;
    });
  }

  Future<Geo.Position> getPosition() async {
    Geo.GeolocationStatus geolocationStatus = await Geo.Geolocator().checkGeolocationPermissionStatus();
    if (geolocationStatus != Geo.GeolocationStatus.granted) {
      return null;
    }
    return await Geo.Geolocator().getCurrentPosition(desiredAccuracy: Geo.LocationAccuracy.medium);
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              Navigator.pushNamed(context, "/settings");
            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        backgroundColor: Color.fromRGBO(24, 23, 23, 0),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255), size: 24),
      ),
      body: Builder(
        builder: (context) {
          return Stack(
            children: <Widget>[
              MapboxMap(
                initialCameraPosition:
                CameraPosition(
                    target: LatLng(37.555033, 126.970904),
                    zoom: 13),
                onMapCreated: (controller) async {
                  mapController = controller;
                  position = await getPosition();
                  mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(position.latitude, position.longitude), 14));
                },
                styleString: MapboxStyles.DARK,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.None,
                trackCameraPosition: true,
                compassEnabled: true,
                myLocationRenderMode: MyLocationRenderMode.GPS,
              ),
              SizedBox(
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromRGBO(24, 23, 23, 1), Color.fromRGBO(24, 23, 23, 0.7), Color.fromRGBO(24, 23, 23, 0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: 8,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 16),
                    itemBuilder: (context, index) {
                      return CircularStroyWidget(
                          day: index + 1,
                          thumbnailUrl: "https://firebasestorage.googleapis.com/v0/b/momentrip-32cf2.appspot.com/o/mypage_07.png?alt=media&token=b5e89b97-42df-48fe-b9e0-4d477e84a5fa");
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 31),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      //ImagePicker.pickVideo(source: ImageSource.camera);
                      int result = await Navigator.pushNamed(context, "/camera", arguments: TravelArgument(tripIdx: tripIdx, position: position));
                      if (result == 0) {
                        // 여행 상세 다시 받기.
                      }
                    },
                    child: Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      )
    );
  }

}

class TravelArgument {
  int tripIdx;
  Geo.Position position;

  TravelArgument({this.tripIdx, this.position});
}
