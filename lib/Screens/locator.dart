import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class Locator {
  late GoogleMapController mapController;
  Position? position;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final StreamController<Set<Marker>> _streamController =
      StreamController<Set<Marker>>();
  Stream<Set<Marker>> get markerStream => _streamController.stream;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    this.position = position;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15)));
    markerCreate();
    _streamController.add(markers.values.toSet());
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void markerCreate() {
    if (position != null) {
      final marker = Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(position!.latitude, position!.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'My location', snippet: '$position'),
      );
      markers[MarkerId('currentLocation')] = marker;

      addMarker(
        'Santo Amaro',
        -8.049776712513152,
        -34.88282349944875,
        'https://www.google.com/maps/place/Delegacia+da+Mulher/@-8.0500587,-34.8920407,16.06z/data=!4m10!1m2!2m1!1sdelegacia+da+mulher+em+recife!3m6!1s0x7ab18931ec711af:0x2f81f4225deb324b!8m2!3d-8.0499813!4d-34.8828561!15sCh1kZWxlZ2FjaWEgZGEgbXVsaGVyIGVtIHJlY2lmZZIBEXBvbGljZV9kZXBhcnRtZW504AEA!16s%2Fg%2F1yg4fhylc?entry=ttu',
      );
      addMarker('Recife Antigo', -8.061293859757267, -34.870989012917335,
          'https://maps.app.goo.gl/amvsoyDGjNv3Kdye7');
          
    }
  }

  void addMarker(
      String markerName, double latitude, double longitude, String url) {
    final MarkerId markerId = MarkerId(markerName);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(latitude, longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      infoWindow: InfoWindow(
        title: markerName,
        snippet: 'Clique para obter mais informações',
      ),
      onTap: () {
        _launchURL(url);
      },
    );

    markers[markerId] = marker;
    _streamController.add(markers.values.toSet());
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await _determinePosition();
    if (position != null) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position!.latitude, position!.longitude),
            zoom: 15,
          ),
        ),
      );
      markerCreate();
    }
  }
}
