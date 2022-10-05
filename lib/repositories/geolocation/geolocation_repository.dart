import 'package:geolocator/geolocator.dart';
import 'package:property_app/repositories/geolocation/base_geolocation_repository.dart';

class GeoLocationRepository extends BaseGeolocatiobnRepository {
  GeoLocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
