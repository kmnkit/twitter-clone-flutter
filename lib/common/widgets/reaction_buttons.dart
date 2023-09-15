import 'package:assign_11/constants/globals.dart';
import 'package:assign_11/features/settings/view_models/settings_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReactionButtons extends ConsumerWidget {
  const ReactionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsProvider).isDarkMode;

    return SizedBox(
      width: 356 * MediaQuery.sizeOf(context).width / standardWidth,
      height: 60 * MediaQuery.sizeOf(context).height / standardHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FaIcon(
            FontAwesomeIcons.heart,
            color: isDarkMode ? Colors.white : Colors.grey.shade900,
          ),
          FaIcon(
            FontAwesomeIcons.comment,
            color: isDarkMode ? Colors.white : Colors.grey.shade900,
          ),
          FaIcon(
            FontAwesomeIcons.retweet,
            color: isDarkMode ? Colors.white : Colors.grey.shade900,
          ),
          Image(
            image: const AssetImage(
              "assets/img/plane.png",
            ),
            width: 24,
            color: isDarkMode ? Colors.white : Colors.grey.shade900,
          ),
        ],
      ),
    );
  }
}
