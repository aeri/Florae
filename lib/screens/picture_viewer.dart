import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PictureViewer extends StatelessWidget {
  const PictureViewer({super.key, this.picture});

  final String? picture;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        panEnabled: false,
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.5,
        maxScale: 2,
        child: Image.file(
          File(picture!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
