// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../core/constants.dart';

class TopBar extends StatelessWidget {
  final String _barTitle;
  Widget? primaryAction;
  Widget? secondaryAction;
  double? fontSize;

  TopBar(this._barTitle,
      {super.key,
      this.primaryAction,
      this.secondaryAction,
      this.fontSize = 35});

  @override
  Widget build(BuildContext context) {
    return _buildUI(context);
  }

  Widget _buildUI(BuildContext context) {
    return SizedBox(
      height: Device().height(context) * 0.10,
      width: Device().width(context),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (secondaryAction != null) secondaryAction!,
          _titleBar(),
          if (primaryAction != null) primaryAction!
        ],
      ),
    );
  }

  Widget _titleBar() {
    return Text(
      _barTitle,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w700),
    );
  }
}
