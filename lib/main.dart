import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:volantis_weather_app/bloc/search_event.dart';
import 'package:volantis_weather_app/model/LocationModel.dart';
import 'package:volantis_weather_app/repositories/search_repository.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'bloc/search_bloc.dart';
import 'bloc/search_state.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const VolantisWeatherApp());
}

class VolantisWeatherApp extends StatefulWidget {
  const VolantisWeatherApp({Key? key}) : super(key: key);

  @override
  State<VolantisWeatherApp> createState() => _VolantisWeatherAppState();
}

class _VolantisWeatherAppState extends State<VolantisWeatherApp> {

  final SearchBloc _searchBloc = SearchBloc(searchRepository: SearchRepository());

  final Geolocator geolocator = Geolocator();

  late Position _currentPosition;
  late String _currentAddress;
  String location = "Yogyakarta";
  String weather = 'clear';
  int temperature = 0;

  @override
  void initState(){
    //  Geolocator
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    //     .then((Position position) {
    //   // _searchBloc.add(FetchCurrentLocation(currentPosition: position));
    //    setState(() {
    //      _currentPosition = position;
    //    });
    //    _getAddressFromLatLng();
    //  }).catchError((e) {
    //   print(e);
    // });
    _searchBloc.initialState;
    super.initState();
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await GeocodingPlatform.instance.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });

      onTextFieldSubmitted(place.locality!);

      print(place.locality);
    } catch (e) {
      print(e);
    }
  }

  void onTextFieldSubmitted(String city) async{
    fetchSearch(city);
  }

  void fetchSearch(String city) async{
    setState(() {
      _searchBloc.add(FetchSearch(inputCity: city));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/clear.png'),
            fit: BoxFit.cover
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BlocProvider(
                  create: (_) => _searchBloc,
                  child: BlocListener<SearchBloc, SearchState>(
                    listener: (context, state) {
                      if(state is SearchFailure){
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state){
                        if(state is SearchInitial){
                          return _buildCurrentWeather();
                        }else if(state is SearchLoading){
                          return _buildLoading();
                        }else if(state is SearchLoaded){
                          _searchBloc.add(FetchLocation(inputCity: state.search!.name));
                        }else if(state is LocationLoaded){
                          return _buildSearchedCityWeather(context, state.locationModel);
                        }else if(state is CurrentLocationLoaded){
                          _searchBloc.add(FetchLocation(inputCity: state.placemark.locality!));
                        }
                        else if(state is SearchFailure){
                          return Container();
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget _buildCurrentWeather(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 200,
                child: TextField(
                  onSubmitted: (String input) {
                    onTextFieldSubmitted(input);
                  },
                  style: TextStyle(color: Colors.white, fontSize: 24),
                  decoration: const InputDecoration(
                      hintText: "Cari kota",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                      prefixIcon: Icon(Icons.search, color: Colors.white)
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "Cuaca Hari Ini",
                  style: const TextStyle(color: Colors.white, fontSize: 48.0),
                ),
              ),
              // Center(
              //   child: Text(
              //     "Bagaimana cuaca hari ini?",
              //     style: const TextStyle(color: Colors.white, fontSize: 72.0),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchedCityWeather(BuildContext context, LocationModel? locationModel){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 200,
                child: TextField(
                  onSubmitted: (String input) {
                    onTextFieldSubmitted(input);
                  },
                  style: TextStyle(color: Colors.white, fontSize: 24),
                  decoration: const InputDecoration(
                      hintText: "Cari kota lain",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                      prefixIcon: Icon(Icons.search, color: Colors.white)
                  ),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Center(
                child:
                Text(
                  locationModel!.location.name,
                  style: const TextStyle(color: Colors.white, fontSize: 48.0),
                ),
              ),
              Center(
                child: Text(
                  locationModel.current.temp_c.toString() +' °C',
                  style: const TextStyle(color: Colors.white, fontSize: 72.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
        child: Container(
          padding: EdgeInsets.only(top: 160.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  const [
              CircularProgressIndicator(color: Colors.white,)
            ],
          ),
        )
    );
  }

}



