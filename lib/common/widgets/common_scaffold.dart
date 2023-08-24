import 'package:assign_11/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomBar;
  const CommonScaffold({
    super.key,
    this.appBar,
    this.bottomBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ??
          AppBar(
            elevation: 0,
            title: const SizedBox(
              width: Sizes.size52,
              height: Sizes.size52,
              child: FaIcon(
                FontAwesomeIcons.twitter,
                color: Color(0xFF4d98e9),
                size: Sizes.size40,
              ),
            ),
          ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(
          Sizes.size32,
        ),
        child: body,
      )),
      bottomNavigationBar: bottomBar,
    );
  }
}
