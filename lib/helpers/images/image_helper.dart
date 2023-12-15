import 'package:flutter/material.dart';

part 'image_names.dart';

class ImageHelper {
  static const String _pathToImageAssets = 'assets';

  static Image getImage(
    String? name, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image(
      image: AssetImage('$_pathToImageAssets/images/$name.png'),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
