import 'package:geolocator/geolocator.dart';


abstract class BaseGeolocatiobnRepository {
  Future<Position?> getCurrentLocation();
}