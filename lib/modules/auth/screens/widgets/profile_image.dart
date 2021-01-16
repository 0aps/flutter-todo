import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final File image;
  final double radius;
  final double width;
  final double height;

  const ProfileImage({
    Key key,
    this.image,
    this.radius = 105,
    this.width = 200,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.amberAccent,
      child: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.file(
                image,
                width: width,
                height: height,
                fit: BoxFit.fitHeight,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(radius),
              ),
              width: width,
              height: height,
              child: Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
            ),
    );
  }
}
