import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserGoogleMap extends StatefulWidget {
  @override
  State<UserGoogleMap> createState() => UserGoogleMapState();

  final Function(LatLng latLng)? callback;

  UserGoogleMap({this.callback});
}

class UserGoogleMapState extends State<UserGoogleMap> {
  late GoogleMapController? _controller;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  final CameraPosition _userPickUpLocation = CameraPosition(
    target: LatLng(lat, lng),
    zoom: 14.4746,
  );

  var marker = Marker(
      markerId: const MarkerId('UserPickUpLocation'),
      position: LatLng(lat, lng));

  static double lat = 37.42796133580664;
  static double lng = -122.085749655962;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.my_location),
          onPressed: () {
            _getCurrentLocation();
          }),
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          trafficEnabled: false,
          buildingsEnabled: false,
          zoomControlsEnabled: false,
          onTap: (LatLng latLng) {
            marker = Marker(
                markerId: const MarkerId('UserPickUpLocation'),
                position: latLng);
            //widget.callback(latLng);
            setState(() {});
          },
          markers: {marker},
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          initialCameraPosition: _userPickUpLocation,
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    lat = position.latitude;
    lng = position.longitude;
    marker = Marker(
        markerId: const MarkerId('UserPickUpLocation'),
        position: LatLng(lat, lng));
    // widget.callback(LatLng(lat, lng));
    _controller
        ?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14));
    setState(() {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
