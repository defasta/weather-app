import 'package:volantis_weather_app/model/LocationModel.dart';

import '../model/SearchModel.dart';
import '../provider/search_provider.dart';

class SearchRepository{
  final _searchProvider = SearchProvider();

  Future<Search?> fetchSearch(String inputCity){
    return _searchProvider.fetchSearch(inputCity);
  }

  Future<LocationModel?> fetchLocation(String inputCity){
    return _searchProvider.fetchLocation(inputCity);
  }

}

class SearchNetworkError extends Error{}