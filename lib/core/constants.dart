import 'package:flutter/material.dart';

class Device {
  double _deviceHeight = 0;
  double _deviceWidth = 0;
  height(BuildContext context) {
    return _deviceHeight = MediaQuery.of(context).size.height;
  }

  width(BuildContext context) {
    return _deviceWidth = MediaQuery.of(context).size.width;
  }
}
