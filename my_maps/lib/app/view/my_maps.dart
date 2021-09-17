import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMaps extends StatefulWidget {
  const MyMaps({Key? key}) : super(key: key);

  @override
  _MyMapsState createState() => _MyMapsState();
}

class _MyMapsState extends State<MyMaps> {
  GoogleMapController? _mapController;
  Set<Marker> markers = new Set<Marker>();
  Placemark? local;
  Widget res = Text('Localização ainda não foi registrada', textAlign: TextAlign.center,);

  var lat = 0.0;
  var lon = 0.0;

  Future<Position> _checkPosition() async {
    LocationPermission permission;
    bool enabled = await Geolocator.isLocationServiceEnabled();

    if (!enabled) {
      return Future.error('Habilite a localização');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('A Localização precisa ser autorizada');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Autorize acesso a localização nas configurações');
    }

    return await Geolocator.getCurrentPosition();
  }

  getPosition() async {
    try {
      final position = await _checkPosition();
      lat = position.latitude;
      lon = position.longitude;
      _mapController!
          .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lon), 15));
    } catch (e) {
      SnackBar(content: Text('Erro\n' + e.toString()));
    }
  }

  _markPosition() async {
    await getPosition();
    List<Placemark> end = await placemarkFromCoordinates(lat, lon);
    setState(() {
      local = end[0];
    });
    //print(local);
    markers.add(Marker(
        markerId: MarkerId(Random().nextInt(500).toString()),
        position: LatLng(lat, lon),
        infoWindow: InfoWindow(title: "Sua Localzação")));
    while (local == null) {
      res = CircularProgressIndicator();
    }
    res = (local == null)
        ? CircularProgressIndicator()
        : Text(
            local.toString(),
            textAlign: TextAlign.center,
          );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              Text(
                "Localização Atual",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: GoogleMap(
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    mapType: MapType.terrain,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(-15.3064561, -49.6099338), zoom: 13),
                    markers: (markers != null) ? markers : <Marker>[].toSet(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    _markPosition();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        color: Colors.blue,
                      ),
                      Text(
                        '  Marcar Localização',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: res,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
