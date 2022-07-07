import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:volantis_weather_app/bloc/search_event.dart';
import 'package:volantis_weather_app/bloc/search_state.dart';
import 'package:volantis_weather_app/model/LocationModel.dart';

import '../model/SearchModel.dart';
import '../repositories/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{
  final SearchRepository _searchRepository = SearchRepository();

  SearchBloc({required SearchRepository searchRepository}) : super(SearchInitial()){
    searchRepository = SearchRepository();
  }

  @override
  SearchState get initialState => const SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
      SearchEvent event
      ) async*{
    if(event is FetchSearch){
      try{
        yield SearchLoading();
        Search? _search = await _searchRepository.fetchSearch(event.inputCity);
        yield SearchLoaded(search: _search);
      }catch(error){
        yield const SearchFailure(error: "error");
      }
    }
    if(event is FetchLocation){
      try{
        yield SearchLoading();
        LocationModel? _locationModel = await _searchRepository.fetchLocation(event.inputCity);
        yield LocationLoaded(locationModel: _locationModel);
      }catch(error){
        yield const SearchFailure(error: "error");
      }
    }
    if(event is FetchCurrentLocation) {
      try{
        yield SearchLoading();
        List<Placemark> p = await GeocodingPlatform.instance.placemarkFromCoordinates(event.currentPosition.latitude, event.currentPosition.longitude);
        Placemark place = p[0];
        yield CurrentLocationLoaded(placemark: place);
      }catch(error){
        yield const SearchFailure(error: "error");
      }
    }
  }
}