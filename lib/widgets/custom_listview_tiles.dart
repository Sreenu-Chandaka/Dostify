//Packages
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Widgets
import "../widgets/rounded_image.dart";

//Models


class CustomListViewTilesWithActivity extends StatelessWidget {
  final double height;
  final String title, subtitle, imagePath;
  final bool isActive, isActivity;
  final Function onTap;

  const CustomListViewTilesWithActivity(
      {super.key, required this.height,
      required this.title,
      required this.subtitle,
      required this.imagePath,
      required this.isActive,
      required this.isActivity,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => onTap,
        minVerticalPadding: height * 0.20,
        leading: RoundedImageNetworkWithStatusIndicator(
          key: UniqueKey(),
          imagePath: imagePath,
          size: height / 2,
          isActive: false,
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        subtitle: isActivity
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitThreeBounce(
                    color: Colors.white,
                    size: height * 0.10,
                  ),
                ],
              )
            : Text(
                subtitle,
                style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ));
  }
}
