import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imagePath;
  const ImagePreviewScreen({
    super.key,
    required this.imagePath,
  });

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  bool _savedPicture = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview Photo"),
        actions: [
          IconButton(
            onPressed: _saveToGallery,
            icon: FaIcon(
              _savedPicture ? FontAwesomeIcons.check : FontAwesomeIcons.download,
            ),
          ),
        ],
      ),
      body: Image.file(File(widget.imagePath)),
    );
  }

  void _saveToGallery() {
    if (_savedPicture) return;
    _savedPicture = true;

    GallerySaver.saveImage(widget.imagePath, albumName: "Camera");

    final snackBar = SnackBar(
      content: const Text("Image Saved!"),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
