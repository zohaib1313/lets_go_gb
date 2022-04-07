import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSampleDriver extends StatefulWidget {
  LatLng userLocationPickUp;

  MapSampleDriver({required this.userLocationPickUp});

  @override
  State<MapSampleDriver> createState() => MapSampleDriverState();
}

class MapSampleDriverState extends State<MapSampleDriver> {
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _cameraPostion;

  @override
  void initState() {
    super.initState();
    _cameraPostion = CameraPosition(
      target: widget.userLocationPickUp,
      zoom: 14.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        trafficEnabled: false,
        buildingsEnabled: false,
        compassEnabled: true,
        markers: {
          Marker(
              markerId: MarkerId('UserPickUpLocation'),
              position: widget.userLocationPickUp)
        },
        initialCameraPosition: _cameraPostion,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
