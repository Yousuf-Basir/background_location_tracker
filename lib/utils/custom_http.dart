import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:background_location_tracker/utils/toast.dart';
import 'package:flutter/material.dart';

class customHttp {
  static Future sendLocation(
    double latitude,
    double longitude,
  ) async {
    String locationApi = "http://143.110.246.24:5001/location";

    var respponse = await http.post(Uri.parse(locationApi),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "ra_mobile": '1720246831',
          "lat": latitude.toString(),
          "long": longitude.toString(),
        }));
    kToasterFunction(title: "${jsonDecode(respponse.body)}", clr: Colors.green);
  }
}
