import 'package:flutter/material.dart';

ValueNotifier<bool> drawing = ValueNotifier(false);
ValueNotifier<List<Offset>> frame = ValueNotifier([]);
ValueNotifier<List<dynamic>> colors = ValueNotifier([]);
ValueNotifier<bool> videoUploaded = ValueNotifier(false); //ok
ValueNotifier<String> statusNotifier = ValueNotifier('1'); //status
ValueNotifier<String> videoPath = ValueNotifier('');
