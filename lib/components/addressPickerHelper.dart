import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:property_app/bloc/geolocation/geolocation_bloc.dart';

class PinAddressMap extends StatelessWidget {
  const PinAddressMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: BlocBuilder<GeolocationBloc, GeolocationState>(
                  builder: (context, state) {
                if (state is GeolocationLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GeolocationLoaded) {
                  return Gmap(
                    lat: 10,
                    lng: 10,
                  );
                } else
                  return Text('Something Went Wrong!');
              }),
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
                    onPressed: () {},
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class Gmap extends StatelessWidget {
  double lat, lng;
  Gmap({Key? key, required this.lat, required this.lng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 8),
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
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter Your Location',
          suffixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.only(left: 20, bottom: 5, right: 5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
