import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String? location;
  String? time;
  String? flag; //url for flag image
  String? URL; //location url for api endpoint
  bool? isDaytime;//true or false for day/night

  WorldTime({this.location,this.flag,this.URL});

  Future <void> getTime() async {
    try{
    final Uri url = Uri.parse('https://worldtimeapi.org/api/timezone/$URL');
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    //print(data);

    //getting properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    // print(datetime);
    // print(offset);

    //Creating datetime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
    //set datetime to string
    isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
    time = DateFormat.jm().format(now);
    }
    catch(e) {
      print(e);
      time = 'could not get time';
    }
  }

}

