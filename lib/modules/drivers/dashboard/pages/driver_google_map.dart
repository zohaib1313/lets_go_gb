import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSampleDriver extends StatefulWidget {
  @override
  State<MapSampleDriver> createState() => MapSampleDriverState();
}

class MapSampleDriverState extends State<MapSampleDriver> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  static const CameraPosition _userPickUpLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        trafficEnabled: false,
        liteModeEnabled: true,
        buildingsEnabled: false,
        compassEnabled: true,
        markers: {
          const Marker(
              markerId: MarkerId('UserPickUpLocation'),
              position: LatLng(37.42796133580664, -122.085749655962))
        },
        initialCameraPosition: _userPickUpLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
