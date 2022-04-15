/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import 'controller/syn_map_controller.dart';

class SyncMapShowPage extends GetView<SynMapController> {
  const SyncMapShowPage({Key? key}) : super(key: key);
  static const id = '/SyncMapShowPage';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<LocationData?>(
        future: controller.currentLocation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
          if (snapchat.data != null) {
            final LocationData currentLocation = snapchat.data;
            printWrapped(currentLocation.toString());
            return SfMaps(
              layers: [
                MapTileLayer(
                  initialFocalLatLng: MapLatLng(
                      currentLocation.latitude!, currentLocation.longitude!),
                  zoomPanBehavior: MapZoomPanBehavior(
                      minZoomLevel: 15.0,
                      maxZoomLevel: 28.0,
                      focalLatLng: MapLatLng(currentLocation.latitude!,
                          currentLocation.longitude!),
                      enableDoubleTapZooming: true,
                      enablePanning: true,
                      enablePinching: true),
                  tooltipSettings: MapTooltipSettings(
                      color: Colors.grey[700],
                      strokeColor: Colors.white,
                      strokeWidth: 2),
                  controller: controller.osmMapController,
                  initialMarkersCount: 0,
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  markerBuilder: (BuildContext context, int index) {
                    return MapMarker(
                      latitude: currentLocation.latitude!,
                      longitude: currentLocation.longitude!,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      size: Size(20, 20),
                    );
                  },
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
*/
