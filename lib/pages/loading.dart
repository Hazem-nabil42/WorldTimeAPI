import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Aliased import to avoid confusion with Flutter's 'Response' class
import 'dart:convert';
import 'package:flutter/animation.dart';
import 'package:world_time/services//getTimeClass.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String? time = 'loading';

  void getTime() async {
    WorldTime instance = WorldTime(location: 'Berlin', url: 'Europe/Berlin', flag: 'germany.png');
    await instance.getTime();
    print(instance.time);
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.blue,
          size: 80.0,
        ),
      ),
    );
  }
}
