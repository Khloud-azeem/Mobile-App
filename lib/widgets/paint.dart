import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_pt/models/body_painter.dart';
import 'package:http/http.dart' as http;
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'package:my_pt/widgets/painter_widget.dart';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Painter extends StatefulWidget {
  const Painter({Key? key}) : super(key: key);

  @override
  State<Painter> createState() => _PainterState();
}

class _PainterState extends State<Painter> {
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
        await Future.delayed(Duration(milliseconds: 200));
      }
      drawing.value = false;
      frame.value.clear();
    } catch (error) {
      print('error: $error');
    }
  }

  @override
  void dispose() {
    drawing.dispose();
    // frame.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Zeftein')),
      body: FutureBuilder(
          future: getData(width, height, context),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            // return Container();

            return ValueListenableBuilder(
      valueListenable: frame,
      builder: (BuildContext context, List<Offset> _frame, __) {
        if (drawing.value) {
          return CustomPaint(
            child: Container(
                // width: width,
                // height: height,
                ),
            painter: BodyPainter(_frame, colors.value),
          );
        } else {
          return Container();
        }
      },
    );
          }),
    );
  }
}
