import 'dart:convert';

import 'package:pfps_platform/models/model_core.dart';
import 'package:http/http.dart' as http;
import 'package:pfps_platform/models/model_warning.dart';

class CoreNetwork {
  Future<List<CoreClient>> fetchCoreData() async {
    Uri url = Uri.parse(
        'http://capstone.dothome.co.kr/sensor/wemos_app.php?mode=select');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        print(responseData);
        List<CoreClient> coreClients =
            responseData.map((data) => CoreClient.fromJson(data)).toList();

        return coreClients;
      } else {
        // Handle HTTP error status codes here, if needed.
        throw Exception('Failed to load data');
      }
    } catch (err) {
      print('Error: $err');
      rethrow;
    }
  }

  Future<List<WarningModel>> fetchWaringModel(String deviceId) async {
    String deviceName = '';
    final url = Uri.parse(
        'http://capstone.dothome.co.kr/sensor/app_wemos.php?mode=select&device_id=$deviceId');
    try {
      final resource = await http.get(url);
      print(resource.statusCode);
      if (resource.statusCode == 200) {
        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(json.decode(resource.body));
        print('app_wemos $responseData');
        List<WarningModel> warningClients =
            responseData.map((data) => WarningModel.fromJson(data)).toList();
        return warningClients;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      print('error:[$err]');
      rethrow;
    }
  }

  Future<void> onWaring({required String deviceName}) async {
    final url = Uri.parse(
        'http://capstone.dothome.co.kr/sensor/app_wemos.php?mode=warning&device_id=${deviceName.toUpperCase()}');
    print(url);
    final resource = await http.get(url);
    if (resource.statusCode == 200) {
      print('waring body is ${resource.body}');
    } else {}
  }
}

class Insert {
  Future<dynamic> insertData(
      {required String deviceId,
      required String manual,
      required String barrierControl}) async {
    // URL 변경
    final Uri uri = Uri.parse(
        'http://capstone.dothome.co.kr/sensor/app_wemos.php?mode=insert&manual=$manual&barrier_control=$barrierControl&device_id=D001&warning=0');
    print(uri);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, dynamic>{
        "manual": manual,
        "barrier_control": barrierControl,
      },
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      return data;
    } else {
      throw Exception('데이터를 보내지 못했습니다.');
    }
  }

  Future<List<Map<String, dynamic>>> insertData_auto(
      String manual, String barrierControl) async {
    String menu = manual;

    final Uri uri = Uri.parse(
        'http://capstone.dothome.co.kr/sensor/app_wemos.php?mode=insert&manual=$manual&barrier_control=$barrierControl');
    print(uri);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, dynamic>{
        "manual": menu,
        "barrier_control": barrierControl,
      },
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      return data;
    } else {
      throw Exception('데이터를 보내지 못했습니다.');
    }
  }
}
