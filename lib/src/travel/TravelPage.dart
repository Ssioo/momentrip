import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geo;
import 'package:intl/intl.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:momentrip/src/main/models/MainResponse.dart';
import 'package:momentrip/src/travel/models/TravelResponse.dart';
import 'package:momentrip/src/travel/widgets/CircularStoryWidget.dart';
import 'package:momentrip/src/travel/widgets/EmptyCircularStoryWidget.dart';
import 'package:momentrip/src/travel/widgets/VideoSliderCard.dart';
import 'package:snaplist/snaplist.dart';

import '../../main.dart';

class TravelPage extends StatefulWidget {
  @override
  TravelPageState createState() => TravelPageState();
}

class TravelPageState extends State<TravelPage> {
  MapboxMapController mapController;
  MainResult tripSummary;
  Geo.Position position;

  List<TravelResult> travelResults;
  Map<int, List<TravelResult>> travelMap;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        tripSummary = ModalRoute
            .of(context)
            .settings
            .arguments;
      });
    });
  }

  Future<Geo.Position> getPosition() async {
    Geo.GeolocationStatus geolocationStatus = await Geo.Geolocator().checkGeolocationPermissionStatus();
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
            onPressed: () async {
              dynamic result = await Navigator.pushNamed(
                  context, "/settings", arguments: tripSummary);
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
            alignment: Alignment.topLeft,
            children: <Widget>[
              MapboxMap(
                initialCameraPosition:
                CameraPosition(
                    target: LatLng(37.555033, 126.970904),
                    zoom: 13),
                onMapCreated: (controller) async {
                  mapController = controller;
                  try {
                    travelResults = await tryGetDetail();
                    position = await getPosition();
                    if (travelResults == null) {
                      mapController.animateCamera(CameraUpdate.newLatLngZoom(
                          LatLng(position.latitude, position.longitude), 14));
                    } else {
                      List<LatLng> latLngs = List();
                      for (var point in travelResults) {
                        mapController.addCircle(CircleOptions(
                            geometry: LatLng(point.lat, point.lng),
                            circleRadius: 8,
                            circleOpacity: 1,
                            circleColor: "#FF653E"));
                        latLngs.add(LatLng(point.lat, point.lng));
                      }
                      mapController.addLine(LineOptions(
                          geometry: latLngs,
                          lineColor: "#FFFFFF",
                          lineWidth: 1
                      ));
                      mapController.animateCamera(CameraUpdate.newLatLngZoom(
                          LatLng(latLngs
                              .elementAt(0)
                              .latitude - 0.0015, latLngs
                              .elementAt(0)
                              .longitude), 15));
                      mapController.onCircleTapped.add((circle) {
                        mapController.animateCamera(CameraUpdate.newLatLngZoom(
                            circle.options.geometry, 16));
                      });
                    }
                  } catch (e) {

                  }
                },
                styleString: MapboxStyles.DARK,
                myLocationEnabled: tripSummary == null || tripSummary.startedAt == null,
                myLocationTrackingMode: MyLocationTrackingMode.None,
                trackCameraPosition: true,
                compassEnabled: true,
                myLocationRenderMode: MyLocationRenderMode.NORMAL,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(24, 23, 23, 1),
                        Color.fromRGBO(24, 23, 23, 0.7),
                        Color.fromRGBO(24, 23, 23, 0)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                ),
              ),
              Container(
                height: 110,
                margin: EdgeInsets.only(top: 100),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      VerticalDivider(
                        width: 4,
                      ),
                  itemCount: (travelMap == null || travelMap.keys.length < 5) ? 5 : travelMap.keys.length,
                  padding: EdgeInsets.only(left: 20, right: 20,),
                  itemBuilder: (context, index) {
                    if (travelMap != null && index < travelMap.keys.length) {
                      return CircularStoryWidget(
                        startedAt: tripSummary.startedAt,
                        travelResultInDay: travelMap[index + 1],
                      );
                    } else {
                      return EmptyCircularStoryWidget();
                    }
                  },
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Builder(
                    builder: (context) {
                      var height = MediaQuery.of(context).size.height;
                      if (height < 738) {
                        return Container(
                          height: 0,
                        );
                      }
                      if (travelResults == null) {
                        return Container(
                          height: 0,
                        );
                      }
                      return Container(
                        height: 398,
                        padding: EdgeInsets.only(bottom: 110),

                        child: SnapList(
                          sizeProvider: (index, data) => Size(175, 288),
                          separatorProvider: (index, data) => Size(4, 288),
                          count: travelResults.length,
                          builder: (context, index, data) {
                            TravelResult travel = travelResults.elementAt(index);
                            return VideoSliderCard(
                              idx: travel.videoIdx,
                              title: travel.address,
                              thumbnailUrl: travel.thumbnailUrl,
                              videoUrl: travel.videoUrl,
                            );
                          },
                          padding: EdgeInsets.only(left: 30, right: 30),
                        ),
                      );
                    }),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 31),
                  child: Builder(
                      builder: (context) {
                        if (tripSummary == null || tripSummary.startedAt == null) {
                          return Container(height: 0,);
                        }
                        return FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            if (position == null) {
                              return;
                            }
                            dynamic result = await Navigator.pushNamed(
                                context, "/camera", arguments: TravelArgument(
                                tripIdx: tripSummary.tripIdx,
                                day: getDiff(tripSummary.startedAt),
                                position: position));
                            if (result == "Success") {
                              // 여행 상세 다시 받기.
                              travelResults = await tryGetDetail();
                              TravelResult lastResult = travelResults.elementAt(travelResults.length - 1);
                              mapController.addCircle(CircleOptions(
                                  geometry: LatLng(lastResult.lat, lastResult.lng),
                                  circleRadius: 8,
                                  circleOpacity: 1,
                                  circleColor: "#FF653E"));
                              mapController.lines.elementAt(0).options.geometry.add(LatLng(lastResult.lat, lastResult.lng));
                            }
                          },
                          child: Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 84, 84, 84),
                          ),
                        );
                      }),
                ),
              )
            ],
          );
        },
      )
    );
  }

  int getDiff(String startedAt) {
    if (tripSummary != null) {
      DateTime nowDate = DateTime.now();
      DateTime startDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(tripSummary.startedAt);
      return nowDate.difference(startDate).inDays + 1;
    } else {
      return 1;
    }
  }

  Future<List<TravelResult>> tryGetDetail() async {
    try {
      Response response = await MyApp.getDio().get(
          "/trip/${tripSummary.tripIdx}");
      TravelResponse travelResponse = TravelResponse.fromJson(response.data);
      if (travelResponse == null) {
        throw Exception();
      }
      setState(() {
        travelResults = travelResponse.travelList;
        if (travelResults != null) {
          travelMap = groupBy(travelResults, (key) => key.day);
        }
      });

      return travelResults;
    } catch (e) {
      print(e);
      return null;
    }
  }

}

class TravelArgument {
  int tripIdx;
  Geo.Position position;
  int day;

  TravelArgument({this.tripIdx, this.position, this.day});
}
