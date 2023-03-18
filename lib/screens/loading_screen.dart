import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationAndData();
  }

  void getLocationAndData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    if (context.mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LocationScreen(
                    locationWeather: weatherData,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.amber,
          size: 100.0,
        ),
      ),
    );
  }
}
