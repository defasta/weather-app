import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
abstract class SearchEvent extends Equatable{
  const SearchEvent();
}

class FetchSearch extends SearchEvent{
  final String inputCity;
  const FetchSearch({required this.inputCity});
  @override
  List<Object?> get props => [inputCity];
}

class FetchLocation extends SearchEvent{
  final String inputCity;
  const FetchLocation({required this.inputCity});
  @override
  List<Object?> get props => [inputCity];
}

class FetchCurrentLocation extends SearchEvent{
  final Position currentPosition;
  const FetchCurrentLocation({required this.currentPosition});
  @override
  List<Object?> get props => [currentPosition];
}