import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GeoProvider extends ChangeNotifier {
  bool isVisible = true;

  //MENU
  void activeMenu() {
    (isVisible == false) ? (isVisible = true) : (isVisible = false);
    notifyListeners();
  }

  //MAP
  StreamSubscription? streamSubscription;
  final Location _tracker = Location();
  Marker? marker;
  Circle? circle;
  GoogleMapController? googleMapController;

  CameraPosition initialLocation = const CameraPosition(
    target: LatLng(-12.0337195, -76.9864541),
    zoom: 14.4755,
  );

  void updateMarker(LocationData newLocation) {
    LatLng latLng = LatLng(newLocation.latitude!, newLocation.longitude!);
    marker = Marker(
      markerId: const MarkerId('marcador'),
      position: latLng,
      rotation: newLocation.latitude!,
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: const Offset(0.5, 0.5),
      icon: BitmapDescriptor.defaultMarker,
    );

    circle = Circle(
      circleId: const CircleId('mCicle'),
      radius: newLocation.accuracy!,
      zIndex: 1,
      strokeColor: const Color.fromARGB(255, 252, 144, 4),
      center: latLng,
      fillColor: const Color.fromARGB(255, 250, 187, 106).withAlpha(70),
    );
  }

  void getLocationUser() async {
    try {
      var location = await _tracker.getLocation();

      updateMarker(location);
      notifyListeners();
      if (streamSubscription != null) {
        streamSubscription!.cancel();
      }

      streamSubscription = _tracker.onLocationChanged.listen(
        (event) {
          if (googleMapController != null) {
            googleMapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(event.latitude!, event.longitude!),
                  zoom: 18.00,
                ),
              ),
            );
            updateMarker(event);
            notifyListeners();
          }
        },
      );
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint('Permission denied');
      }
    }
  }
}
