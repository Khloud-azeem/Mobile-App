import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_pt/providers/exercise_video_data.dart';
import 'package:my_pt/screens/exercise_demo_screen.dart';
import 'package:my_pt/screens/loading_screen.dart';
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Demo extends StatefulWidget {
  static const routeName = '/demo';
  Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  Future<void> _onImageButtonPressed(ImageSource source, double height,
      double width, BuildContext context) async {
    XFile? _file;
    final ImagePicker _picker = ImagePicker();

    _file = await _picker.pickVideo(
        source: source, maxDuration: const Duration(seconds: 10));
    videoPath.value = _file!.path;
    if (_file != null) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => LoadingScreen(),
        ),
      );
    }
  }

  Widget Step(String text, double width) {
    return Container(
      width: width,
      // margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(Icons.fitness_center),
          ),
          Flexible(child: Text(text, softWrap: true, style:  TextStyle(fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<ExcerciseVideoData>(context, listen: false);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            // height: height * 0.5,
            child: Stack(
              children: [
                Image.asset('images/squat_demo.gif', fit: BoxFit.scaleDown),
                Container(
                  // height: height,
                  color: Color.fromRGBO(0, 0, 0, .5),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: width,
            child: Column(
              children: [
                // Container(
                //   margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),

                //   alignment: Alignment.topLeft,
                //   child: const Text('INSTRUCTIONS',
                //       style: TextStyle(fontWeight: FontWeight.bold)),
                // ),
                Step('PLACE THE PHONE ABOUT 2M FAR.', width),
                Step('FACE YOUR SIDE VIEW TO THE CAMERA.', width),
                Step('MAKE SURE YOUR FACE SHOWS IN THE SCREEN.', width),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  // alignment: Alignment.topLeft,
                  child: const Text(
                    'YOUR TURN',
                    // textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, .6),
                            Color.fromRGBO(143, 148, 251, 1),
                          ])),
                      child: Center(
                        child: TextButton(
                            child: Text(
                              "OPEN YOUR CAMERA",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              videoData.getStatus();
                              _onImageButtonPressed(
                                  ImageSource.camera, height, width, context);
                            }),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      child: Center(
                        child: TextButton(
                            child: Text(
                              "CHOOSE LOCAL VIDEO",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              videoData.getStatus();
                              _onImageButtonPressed(
                                  ImageSource.gallery, height, width, context);
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.05,
          )
        ],
      ),
    );
  }
}
