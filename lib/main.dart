import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async{

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MapSample()
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  // CameraPosition
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  // Markers
  static const Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title:'Google plex'),
    position: LatLng(37.42796133580664, -122.085749655962),
    );

  static  final Marker _kLakeMarker = Marker(
    
    markerId: const MarkerId('_kLake'),
    infoWindow: const InfoWindow(title: 'Lake'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: const LatLng(37.43296265331129, -122.08832357078792),
    );


  // // Polyline
  // static const _kPolyline = Polyline(
  //   polylineId: PolylineId('polyline'),
  //   color: Colors.red,
  //   width: 5,
  //   points: [
  //     LatLng(37.42796133580664, -122.085749655962),
  //     LatLng(37.43296265331129, -122.08832357078792),
  //   ],
  // );

  // //Polygons
  // static final Polygon _kPolygon = Polygon(
  //   polygonId: const PolygonId('polygon'),
  //   points: const [
  //     LatLng(37.43296265, -122.0883235),
  //     LatLng(37.42796, -122.085749655962),
  //     LatLng(37.418, -122.09283),
  //     LatLng(37.435, -122.09274),
  //   ],
  //   strokeColor: Colors.blue,
  //   strokeWidth: 5,
  //   fillColor: Colors.red.withOpacity(0.5),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: { _kGooglePlexMarker, _kLakeMarker },
        // polylines: { _kPolyline },
        // polygons: { _kPolygon },
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      persistentFooterButtons: [
        FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: const Text('To the lake!'),
          icon: const Icon(Icons.directions_boat),
        ),
        FloatingActionButton.extended(
          onPressed: _defaultView,
          label: const Text('Default View'),
          icon: const Icon(Icons.emoji_transportation),
        ),],
      
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  Future<void> _defaultView() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
}