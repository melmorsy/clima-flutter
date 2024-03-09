import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String openweatherAPIKey = '19d3169bc258407aa0345c320cb74d39';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData().then((data) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(data);
      }));
    });
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

  Future<Position> getLocation() async {
    await Geolocator.requestPermission();
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

  Future getData() async {
    Position position = await getLocation();
    var latitude = position.latitude;
    var longitude = position.longitude;
    var networkHelper = NetworkHelper(Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {'lat': '$latitude', 'lon': '$longitude', 'appid': openweatherAPIKey}));

    return networkHelper.getData();
  }
}
