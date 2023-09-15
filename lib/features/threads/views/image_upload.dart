import 'dart:io';

import 'package:assign_11/features/threads/views/image_preview.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  bool _hasPermission = false;

  bool _isSelfieMode = true;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    _controller = CameraController(
      cameras[_isSelfieMode ? 0 : 1],
      ResolutionPreset.ultraHigh,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> initPermission() async {
    // 카메라 퍼미션 확인
    final cameraPermission = await Permission.camera.request();
    // final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    // final micDenied = micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied) {
      _hasPermission = true;
      setState(() {});
    }
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _controller.setFlashMode(newFlashMode);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPermission();
    initCamera();
  }

  Future<void> toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //&& !_noCamera
            return CameraPreview(_controller);
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ImagePreviewScreen(
                  imagePath: image.path,
                ),
                // Container(
                //   child: Image.file(File(image.path)),
                // ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
    //   SafeArea(
    //     child: SizedBox(
    //       child: !_hasPermission || !_controller.value.isInitialized
    //           ? SizedBox(
    //               width: width,
    //               height: height,
    //               child: const Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Initializing...",
    //                     style: TextStyle(color: Colors.white),
    //                   ),
    //                   Gaps.v20,
    //                   CircularProgressIndicator.adaptive(),
    //                 ],
    //               ),
    //             )
    //           : Stack(
    //               alignment: Alignment.center,
    //               children: [
    //                 CameraPreview(_controller),
    //                 Positioned(
    //                   top: 100 * heightRatio,
    //                   right: 0,
    //                   // right: Sizes.size40 * widthRatio,
    //                   child: Column(
    //                     children: [
    //                       CircleAvatar(
    //                         backgroundColor: Colors.black,
    //                         child: Center(
    //                           child: IconButton(
    //                             color: Colors.white,
    //                             onPressed: toggleSelfieMode,
    //                             icon: Icon(
    //                               _controller.description.lensDirection ==
    //                                       CameraLensDirection.front
    //                                   ? Icons.camera_front_rounded
    //                                   : Icons.camera_rear_rounded,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         width: 50,
    //                         height: height,
    //                         child: FlashFlowMenu(
    //                           onValueChanged: _setFlashMode,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Positioned(
    //                   bottom: Sizes.size40,
    //                   child: FloatingActionButton(
    //                     onPressed: _onTap,
    //                     child: const Icon(Icons.camera_alt),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //     ),
    //   ),
    // );
  }

  void _onTap() async {
    try {
      await _controller.takePicture();
    } catch (e) {
      print(e);
    }
  }
}

class FlashFlowMenu extends StatefulWidget {
  final ValueChanged<FlashMode> onValueChanged;
  const FlashFlowMenu({
    super.key,
    required this.onValueChanged,
  });

  @override
  State<StatefulWidget> createState() => _FlashFlowMenuState();
}

class _FlashFlowMenuState extends State<FlashFlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;
  FlashMode nowFlashMode = FlashMode.off;
  IconData lastTapped = Icons.flare_sharp;
  final flashDatas = [
    [Icons.flash_off_rounded, FlashMode.off],
    [Icons.flash_on_rounded, FlashMode.always],
    [Icons.flash_auto_rounded, FlashMode.auto],
    [Icons.flashlight_on_rounded, FlashMode.torch],
    [Icons.flare_sharp, FlashMode.off],
  ];

  void _updateMenu(IconData icon, FlashMode flashMode) {
    if (icon != Icons.flare_sharp) {
      lastTapped = icon;
      nowFlashMode = flashMode;
      widget.onValueChanged(flashMode);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  Widget flowMenuItem(IconData icon, FlashMode flashMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
        splashColor: Colors.amber.shade100,
        constraints: BoxConstraints.tight(
          const Size(
            50,
            50,
          ),
        ),
        shape: const CircleBorder(),
        onPressed: () {
          _updateMenu(icon, flashMode);

          menuAnimation.status == AnimationStatus.completed
              ? menuAnimation.reverse()
              : menuAnimation.forward();
        },
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(menuAnimation: menuAnimation),
      children: flashDatas
          .map((data) => flowMenuItem(
                data[0] as IconData,
                data[1] as FlashMode,
              ))
          .toList(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> menuAnimation;

  FlowMenuDelegate({
    required this.menuAnimation,
  }) : super(repaint: menuAnimation);

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dy = 0.0;

    for (int i = 0; i < context.childCount; ++i) {
      dy = context.getChildSize(i)!.width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          0,
          dy * menuAnimation.value,
          0,
        ),
      );
    }
  }
}
