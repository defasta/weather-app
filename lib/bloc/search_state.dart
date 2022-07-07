
import 'package:equatable/equatable.dart';
import 'package:volantis_weather_app/model/LocationModel.dart';
import 'package:volantis_weather_app/model/SearchModel.dart';

abstract class SearchState extends Equatable{
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState{
  const SearchInitial();
  List<Object> get props => [];
}

class SearchLoading extends SearchState{
  const SearchLoading();
  List<Object> get props => [];
}

class SearchFailure extends SearchState{
  final String error;
  const SearchFailure({required this.error});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Seacrh failure { error : $error}';
}

class SearchLoaded extends SearchState{
  final Search? search;

  const SearchLoaded({required this.search});
  @override
  String toString() => 'Search Loaded {data: $search}';
  @override
  List<Object> get props => [search!];
}

class LocationLoaded extends SearchState{
  final LocationModel? locationModel;

  const LocationLoaded({required this.locationModel});
  @override
  String toString() => 'Location Loaded {data: $locationModel}';
  @override
  List<Object> get props => [locationModel!];
}

