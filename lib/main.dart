import 'package:flutter/material.dart';

void main() {
  runApp(const VolantisWeatherApp());
}

class VolantisWeatherApp extends StatefulWidget {
  const VolantisWeatherApp({Key? key}) : super(key: key);

  @override
  State<VolantisWeatherApp> createState() => _VolantisWeatherAppState();
}

class _VolantisWeatherAppState extends State<VolantisWeatherApp> {
  String location = "Yogyakarta";
  int temperature = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Scaffold(
          backgroundColor: Colors.lightBlue,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 200,
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 24),
                      decoration: InputDecoration(
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
                    child: Text(
                      location,
                      style: TextStyle(color: Colors.white, fontSize: 48.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      temperature.toString() +' °C',
                      style: TextStyle(color: Colors.white, fontSize: 72.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



