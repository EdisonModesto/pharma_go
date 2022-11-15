import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/my_flutter_app_icons.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:pharma_go/speechRecognition/speechFAB.dart';
import 'package:provider/provider.dart';

import '../notification/NotificationUI.dart';

class mapUI extends StatefulWidget {
  const mapUI({Key? key}) : super(key: key);

  @override
  State<mapUI> createState() => _mapUIState();
}

class _mapUIState extends State<mapUI> {
  List<Marker> markers = [];

  getPharmacies(String searchKey)async{

    final searchResult = await Nominatim.searchByName(
      query: searchKey,
      limit: 50,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );

      searchResult.forEach((element) {
        if(mounted){
          setState(() {
            markers.add(
                Marker(
                  point: latLng.LatLng(element.lat, element.lon),
                  width: 300,
                  height: 300,
                  builder: (context) => const Icon(MyFlutterApp.location, color: Color(0xff219C9C),),
                )
            );
          });
        }
      });
      print("TOTAL MARKERS: ${markers.length}");
  }

  Future<List<Marker>> sendRequests()async{
    getPharmacies("pharmacy san fernando pampanga");
    return markers;
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            width: 40,
                            child: Hero(
                              tag: "logo",
                              child: Image.asset("assets/images/PharmaGo_rounded.png"),

                            ),
                          ),
                          Text(
                            "Welcome ${context.watch<registerProvider>().Name.split(" ")[0]}",
                            style: const TextStyle(
                                fontSize: 16
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        showMaterialModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)
                              )
                          ),
                          context: context,
                          builder: (context) => const notifUI(),
                        );
                      },
                      icon: const Icon(
                        MyFlutterApp.bell,
                        color: Color(0xff219C9C),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Nearby\nPharmacies",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15, top: 15),
                            child: Container(
                              height: 259,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(color: Colors.black, width: 6,
                                  )
                              ),
                              child: FutureBuilder(
                                future: sendRequests(),
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    return FlutterMap(
                                      options: MapOptions(
                                        center: latLng.LatLng(15.0284, 120.6937),
                                        zoom: 11,
                                      ),
                                      nonRotatedChildren: [

                                      ],
                                      children: [
                                        TileLayer(
                                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName: 'com.example.app',
                                        ),
                                        CurrentLocationLayer(
                                          centerOnLocationUpdate: CenterOnLocationUpdate.always,
                                          turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                                          style: const LocationMarkerStyle(
                                            marker: DefaultLocationMarker(
                                              child: Icon(
                                                Icons.navigation,
                                                color: Colors.white,
                                              ),
                                            ),
                                            markerSize: Size(40, 40),
                                            markerDirection: MarkerDirection.heading,
                                          ),
                                        ),
                                        markers.isNotEmpty ? MarkerClusterLayerWidget(
                                          options: MarkerClusterLayerOptions(
                                            maxClusterRadius: 0,
                                            size: const Size(20, 20),
                                            fitBoundsOptions: const FitBoundsOptions(
                                              padding: EdgeInsets.all(50),
                                            ),
                                            markers: snapshot.data!,
                                            polygonOptions: const PolygonOptions(
                                                borderColor: Colors.blueAccent,
                                                color: Colors.black12,
                                                borderStrokeWidth: 3),
                                            builder: (context, markers) {
                                              return FloatingActionButton(
                                                onPressed: null,
                                                child: Text(markers.length.toString()),
                                              );
                                            },
                                          ),
                                        ) : Container()
                                      ],
                                    );
                                  } else {
                                    return const LoadingIndicator(size: 40, borderWidth: 2);
                                  }
                                },
                              )
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: const speechFAB()
    );
  }
}
