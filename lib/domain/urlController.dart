import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Http {
  String url;
  Http({required this.url});
  String? backendUrl = dotenv.env['BACKEND_URL'];
  final dio = Dio();

  Future<String> fetchUrlOfTheVideo() async {
    final RegExp regExp = RegExp(r'https?://(?:www\.)?([a-zA-Z0-9-]+)\.');
    final Match match = regExp.firstMatch(url) as Match;

    if (match.groupCount >= 1) {
      String? companyName = match.group(1)?.trim();
      print("Company Name: $companyName");
      if (companyName == 'x') {
        companyName = "twitter";
      }
      try {
        Response res = await dio
            .post('$backendUrl/api/download/$companyName', data: {'url': url});

        print("this is response ${res.data}");

        if (res.statusCode == 200) {
          Map<String, dynamic> response = res.data; // No need for jsonDecode
          if (response.containsKey('data')) {
            // Check if 'data' is a map
            dynamic data = response['data'];
            if (data is String) {
              // 'data' is a String, you can use it directly
              print("url is here $data");
              return data;
            } else {
              // Handle the case when 'data' is not a String
              print("Data property is not a String.");
            }
          } else {
            print("Data property not found in the response.");
          }
        } else {
          print("Company name not found in the URL.");
        }
      } catch (e) {
        throw e;
      }
    }
    return "NOT VALID URL";
  }
}
