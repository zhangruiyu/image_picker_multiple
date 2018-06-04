import 'dart:async';

import 'package:flutter/services.dart';

class MultipleImagePicker {
  static const MethodChannel _channel =
  const MethodChannel('multiple_image_picker');

  static Future<List<dynamic>> pickImage([List<dynamic> selectedPics]) async {
    List<dynamic> selectPics = await _channel.invokeMethod(
        'pickImage', {'selectedPics': selectedPics ?? new List<dynamic>()});
    return selectPics;
  }
}
