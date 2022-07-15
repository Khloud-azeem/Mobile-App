import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'dart:convert';

class ExcerciseVideoData with ChangeNotifier {
  Future<dynamic> uploadFile(File file) async {
    var uri = Uri.parse('http://192.168.1.9:8000/fileUploadApi/');
    // var uri = Uri.parse('http://awatef.pythonanywhere.com/fileUploadApi/');
    try {
      var filename = file.path;
      var request = http.MultipartRequest('POST', uri);
      request.files
          .add(await http.MultipartFile.fromPath('file_uploaded', filename));
      var response = await request.send();
      if (response.reasonPhrase == 'OK') {
        videoUploaded.value = true;
      }
      return response.reasonPhrase;
    } catch (error) {
      print('error: $error');
      rethrow;
    }
  }

  Future<void> getStatus() async {
    var uri = Uri.parse('http://192.168.1.9:8000/getStatus/');
    while (true) {
      try {
        var statusResponse = await http.get(uri);
        var status = statusResponse.body;
        statusNotifier.value = status;
        // print('status: $status');
      } catch (error) {
        print('error: $error');
        rethrow;
      }
    }
  }

  Future<void> getData(
      double width, double height, BuildContext context) async {
    try {
      List<Offset> jsonList = [];
      List<List<dynamic>> colorsList = [];
      drawing.value = true;
      String path =
          "E:/Flutter/Projects/my_pt/Backend_m/env/Backend/MyPersonalTrainer/Points.json";
      // "E:/Flutter/Projects/my_pt/django_m/env/Backend/MyPersonalTrainer/Points.json";

      String data = await DefaultAssetBundle.of(context).loadString(path);
      var jsonData = await json.decode(data);
      jsonData.forEach((frame) {
        frame.forEach((point, value) {
          // print(point);
          // print(value);
          if (point == 'Values') {
            // print('values');
            colorsList.add(value);
          } else {
            // print('positions');
            var globalPos = Offset(value[0].toDouble(), value[1].toDouble());
            jsonList.add(globalPos);
          }
        });
      });
      // print('legnth of data is ${jsonList.length}');
      // print("Json list is $jsonList");
      // print('state list is: $colors');
      var remaining = jsonList.length;
      frame.value.clear();
      List<Offset> currentFrame;
      for (int i = 0, c = 0;
          i < jsonList.length && c < colorsList.length;
          i = i + 33, c++) {
        // for (int i = 0; i < jsonList.length; i = i + 33) {
        currentFrame = [];
        for (var j = i; j <= (i + 32); j++) {
          if (remaining < 32) {
            for (var k = 0; k < remaining; k++) {
              currentFrame.add(jsonList[k]);
            }
          } else {
            currentFrame.add(jsonList[j]);
          }
        }
        frame.value = currentFrame;
        colors.value = colorsList[c];
        remaining = remaining - 32;
        // print("Frame list in get function ${frame.value}");
        // print("Colors list in get function ${colors.value}");
        await Future.delayed(Duration(milliseconds: 30));
      }
      drawing.value = false;
      frame.value.clear();
      File jsonFile = File(path);
      var deleteResult = await jsonFile.delete();
      print('delete: $deleteResult');
    } catch (error) {
      print('error: $error');
      rethrow;
    }
  }
}
