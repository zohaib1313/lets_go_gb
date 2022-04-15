/*
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

const double _osmMinimumZoomLevel = 15.0;
const double _osmMaximumZoomLevel = 18.0;
const double _googleMapMinimumZoomLevel = 16.0;

class SynMapController extends GetxController {
  var temp = 0.obs;

  var osmMapController = MapTileLayerController();

  Future<LocationData?> currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return await location.getLocation();
    */
/* LocationData locationData = await location.getLocation();
    _initialOsmLatLng = MapLatLng(locationData.latitude ?? 29.3957205095743,
        locationData.longitude ?? 71.68344140052797);

    osmZoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: _osmMinimumZoomLevel,
      maxZoomLevel: _osmMaximumZoomLevel,
      focalLatLng: _initialOsmLatLng,
      enableDoubleTapZooming: true,
    );*/ /*

  }
}
*/
