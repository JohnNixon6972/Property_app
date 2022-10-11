// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocode/geocode.dart';
import 'package:property_app/screens/addPropertiesScreen2.dart';
import 'package:property_app/screens/editPropertyScreen1.dart';
import 'package:property_app/screens/editPropertyScreen2.dart';
import '../screens/addPropertiesScreen1.dart';

late var _origin = null;
Address address = Address();

class PinAddressMap extends StatefulWidget {
  const PinAddressMap({
    Key? key,
  }) : super(key: key);

  @override
  State<PinAddressMap> createState() => _PinAddressMapState();
}

class _PinAddressMapState extends State<PinAddressMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Gmap(
              lat: 10,
              lng: 10,
            ),
            const Positioned(
                top: 20, left: 20, right: 20, child: LocationSearchBox()),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    child: const Text("Save Location"),
                    onPressed: () async {
                      GeoCode geoCode =  GeoCode();
                      Address address = await geoCode.reverseGeocoding(
                          latitude: _origin.position.latitude,
                          longitude: _origin.position.longitude);
                      setState(() {
                        // print(address.streetAddress);
                        // print(address.region);
                        PropertyAddress = address.streetAddress!;
                        EPropertyAddress = address.streetAddress!;
                        latitude = _origin.position.latitude.toString();
                        longitude = _origin.position.longitude.toString();
                        Elatitude = _origin.position.latitude.toString();
                        Elongitude = _origin.position.longitude.toString();
                        Navigator.pop(context);
                      });
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class Gmap extends StatefulWidget {
  double lat, lng;
  Gmap({Key? key, required this.lat, required this.lng}) : super(key: key);

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(11.1271, 78.6569), zoom: 10);

  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }

  void _addMarker(LatLng pos) {
    setState(() {
      _origin = Marker(
          markerId: const MarkerId("origin"),
          position: pos,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(title: "Origin"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: {
          if (_origin != null) _origin,
        },
        onLongPress: _addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition)),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}

class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            "Hold on the map to select location",
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
