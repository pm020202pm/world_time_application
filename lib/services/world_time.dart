import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDaytime;

  WorldTime({required this.location, required this.flag,required this.url});

  Future<void> getTime() async {
    var response = await get(Uri.https('worldtimeapi.org','api/timezone/$url'));
    var data = jsonDecode(response.body);

    //get properties from data
    String datetime=data['utc_datetime'];
    String offset=data['utc_offset'].substring(1,3);
    String offset1=data['utc_offset'].substring(4,6);
    String sign = data['utc_offset'].substring(0,1);

    //create DateTime object
    DateTime now= DateTime.parse(datetime);
    now= sign== '+'? now.add(Duration(hours: int.parse(offset), minutes: int.parse(offset1))) : now.subtract(Duration(hours: int.parse(offset), minutes: int.parse(offset1)));

    // create time object
    time= DateFormat.jm().format(now);

    //create bg day/night image
    isDaytime= now.hour> 6 && now.hour<19? true : false;
  }
}