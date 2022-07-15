import 'package:flutter/material.dart';
import 'package:my_pt/models/body_painter.dart';
import 'package:my_pt/value_notifiers/value_notifiers.dart';

class PainterWidget extends StatefulWidget {
  @override
  State<PainterWidget> createState() => _PainterWidgetState();
}

class _PainterWidgetState extends State<PainterWidget> {
  @override
  void dispose() {
    // drawing.dispose();
    // frame.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
  }
}
