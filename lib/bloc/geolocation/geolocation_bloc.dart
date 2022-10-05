import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:property_app/repositories/geolocation/geolocation_repository.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeoLocationRepository _geoLocationRepository;
  StreamSubscription? _geoLocationSubscription;

  GeolocationBloc({required GeoLocationRepository geoLocationRepository})
      : _geoLocationRepository = geoLocationRepository,
        super(GeolocationLoading());

  @override
  Stream<GeolocationState> mapEventToState(
    GeolocationEvent event,
  ) async* {
    if(event is LoadGeolocation){
      yield* _mapLoadGeoLocationToState();
    }else if(event is UpdateGeolocation){
      yield* _mapUpdateGeoLocationToState(event);
    }
  }

  Stream<GeolocationState> _mapLoadGeoLocationToState() async* {
    _geoLocationSubscription?.cancel();
   final Position position = await _geoLocationRepository.getCurrentLocation();
    add(UpdateGeolocation(position: position));
  }

  Stream<GeolocationState> _mapUpdateGeoLocationToState(UpdateGeolocation event) async* {
    yield GeolocationLoaded(position:event.position);
  }

  @override
  Future<void> close() {
    _geoLocationSubscription?.cancel();
    return super.close();
  }
}
