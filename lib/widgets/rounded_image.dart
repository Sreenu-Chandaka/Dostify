import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RoundedImageNetwork extends StatelessWidget {
  final double size;
  final String imagePath;
  const RoundedImageNetwork(
      {required Key key, required this.size, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imagePath), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(size)),
          color: Colors.black),
    );
  }
}

class RoundedImageFile extends StatelessWidget {
  final double size;
  final PlatformFile image;
  const RoundedImageFile(
      {required Key key, required this.size, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: FileImage(File(image.path!)), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(size)),
          color: Colors.black),
    );
  }
}
