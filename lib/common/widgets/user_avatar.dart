import 'package:assign_11/constants/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final Widget floatingIcon;
  final Widget? trailing;
  const UserAvatar({
    super.key,
    this.imageUrl,
    this.trailing,
    required this.floatingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        CircleAvatar(
          radius: width * 100 / standardWidth / 2,
          backgroundImage: const AssetImage('assets/img/user_placeholder.png'),
          foregroundImage:
              imageUrl != null ? CachedNetworkImageProvider(imageUrl!) : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Container(
                width: width * 42 / standardWidth,
                height: width * 42 / standardWidth,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(23),
                    child: floatingIcon,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ReportListTile extends ListTile {
  final String text;
  final Function onTapFunction;
  const ReportListTile({
    super.key,
    required this.text,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTapFunction(),
      title: Text(
        text,
      ),
      trailing: trailing,
    );
  }
}
