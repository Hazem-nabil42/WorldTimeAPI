import 'package:http/http.dart' as http; // Aliased import to avoid confusion with Flutter's 'Response' class
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {
  String location;
  String url;
  String flag;
  String? time;
  bool? isDayTime;

  WorldTime ({ required this.location, required this.url, required this.flag });

  Future<void> getTime() async {
    try {
      http.Response response = await http.get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String datetime = data['datetime'];
        String offset = data['utc_offset'].substring(1, 3);

        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(hours: int.parse(offset)));

        time = DateFormat.jm().format(now);

        isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      } else {
        print('Failed to load time data');
      }
    } catch (e) {
      print('Error: $e');
      time = 'could not update time data';
    }
  }
}