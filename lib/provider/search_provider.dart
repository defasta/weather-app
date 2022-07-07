import 'package:dio/dio.dart';
import 'package:volantis_weather_app/model/LocationModel.dart';
import 'package:volantis_weather_app/model/SearchModel.dart';

class SearchProvider{
  final Dio _dio = Dio();
  static String mainUrl = "https://api.weatherapi.com/v1";

  Future<Search?> fetchSearch(String inputCity) async{
    var searchUrl ='$mainUrl/current.json?key=57017a7de4ec401388060726220707&q=$inputCity';
    try{
      Response response = await _dio.get(searchUrl);
      print('My URL :  $searchUrl');
      print("data : ${response.data}");
      // List<Search> search = Search.fromJson(response.data) as List<Search>;
      // return search;
      return Search.fromJson(response.data['location']);
    }catch(error, stacktrace){
      print(
          "Exception occured: $error stackTrace: $stacktrace ");
      // return<Search>[];
    }
  }

  Future<LocationModel?> fetchLocation(String inputCity) async{
    var locationUrl ='$mainUrl/current.json?key=57017a7de4ec401388060726220707&q=$inputCity&aqi=no';
    try{
      Response response = await _dio.get(locationUrl);
      print('My URL :  $locationUrl');
      print("data : ${response.data}");
      return LocationModel.fromJson(response.data);
    }catch(error, stacktrace){
      print(
          "Exception occured: $error stackTrace: $stacktrace ");
    }
  }
}