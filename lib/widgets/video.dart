import 'package:my_pt/providers/exercise_video_data.dart';
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'package:my_pt/widgets/painter_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Videoo extends StatefulWidget {
  const Videoo({Key? key}) : super(key: key);

  @override
  State<Videoo> createState() => _VideooState();
}

class _VideooState extends State<Videoo> {
  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  final ImagePicker _picker = ImagePicker();

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Future<dynamic> initVideoPlayer() async {
    _controller = VideoPlayerController.file(File(videoPath.value));
    var _initializedControllerFuture = _controller!.initialize();
    _controller!.setLooping(false);
    return _initializedControllerFuture;
  }

  void _playVideo(File? file) {
    // try {
    //   if (file != null) {
    // await _disposeVideoController();

    // _controller = VideoPlayerController.file(File(videoPath.value));
    // await _controller!.initialize();
    // await _controller!.setLooping(false);
    _controller!.play();
    // setState(() {});
    // }
    // } catch (error) {
    //   print('error: $error');
    // }
  }

  Future<void> _onImageButtonPressed(ImageSource source, double height,
      double width, BuildContext context) async {
    XFile? _file;
    final ImagePicker _picker = ImagePicker();

    _file = await _picker.pickVideo(
        source: source, maxDuration: const Duration(seconds: 10));
    videoPath.value = _file!.path;
    await initVideoPlayer();
    setState(() {});

    // await _playVideo(_file);
  }

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<ExcerciseVideoData>(context, listen: false);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Zeft')),
      body: FutureBuilder(
          future:
              // Future.delayed(Duration(seconds: 1)),
              // _playVideo(File(videoPath.value)),
              videoData.getData(width, height, context),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("waiting");
            }
            print("i'm ready");
            _playVideo(File(videoPath.value));
            return _controller!.value.isInitialized
                ? Stack(
                    children: <Widget>[
                      // Container(
                      //   child: AspectRatio(
                      //     aspectRatio: _controller!.value.aspectRatio,
                      //     child: VideoPlayer(_controller!),
                      //   ),
                      // ),
                      PainterWidget()
                    ],
                  )
                : Text('not initialized');
          }),
      // _controller != null
      //     ? Container(
      //         child: AspectRatio(
      //         aspectRatio: _controller!.value.aspectRatio,
      //         child: VideoPlayer(_controller!),
      //       )
      // VideoPreview(
      //   retrieveLostData: retrieveLostData,
      //   previewVideo: _previewVideo,
      // ),
      // )
      // : Container(),
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              _onImageButtonPressed(ImageSource.gallery, 500, 500, context)),
    );
  }
}

// class MySpecificPage extends StatefulWidget {
//     @override
//     State<StatefulWidget> createState() {
//         return _MySpecificPageState();
//     }
// }

// class _MySpecificPageState extends State<MySpecificPage> {

//     VideoPlayerController? controller;
//     VoidCallback? listener;

//     @override
//     void initState() {
//         listener = () => setState(() {});
//         videoHandler();
//         super.initState();
//     }
//   Future<void> _onImageButtonPressed(ImageSource source, double height,
//       double width, BuildContext context) async {
//     XFile? _file;
//     final ImagePicker _picker = ImagePicker();

//     _file = await _picker.pickVideo(
//         source: source, maxDuration: const Duration(seconds: 10));
//     videoPath.value = _file!.path;
//     // setState(() {});

//     // await _playVideo(_file);
//   }
//     void videoHandler() {
//         if (controller == null) {
//             controller = VideoPlayerController.file(File(videoPath.value))
//                 ..addListener(()=>listener!())
//                 ..setVolume(0.5)
//                 ..initialize();
//         } else {
//             if (controller!.value.isPlaying) {
//                 controller!.pause();
//             } else {
//                 controller!.play();
//             }
//         }
//     }


//     @override
//     Widget build(BuildContext context) {
//         return Scaffold(
//             appBar: AppBar(
//                 title: Text('Videop Provider Example'),
//             ),
//             body:Container(
//             child: Column(
//                 children: <Widget>[
//                     VideoProvider(controller!),
//                     RaisedButton(
//                         child: Text('click here to play & puase the video'),
//                         onPressed: () {
//                             videoHandler();
//                         },
//                         )
//                 ],
//                 ),
//             ),
//             floatingActionButton: FloatingActionButton(
//           onPressed: () =>
//               _onImageButtonPressed(ImageSource.gallery, 500, 500, context)),
//     );
        
//     }
// }

// class VideoProvider extends StatelessWidget {
//     final VideoPlayerController controller;

//     VideoProvider(this.controller);

//     @override
//     Widget build(BuildContext context) {
        // return AspectRatio(
//             aspectRatio: 16 / 9,
//             child: VideoPlayer(
//                 controller
//             ),
//         );
//     }
// }

