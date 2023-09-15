import 'package:assign_11/constants/activity_types.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatingIconContainer extends StatelessWidget {
  final ActivityType type;
  const FloatingIconContainer({
    super.key,
    required this.type,
  });

  static final colors = [
    Colors.green.shade400,
    Colors.blue.shade400,
    Colors.purple.shade400,
    Colors.pink.shade400,
  ];

  static final symbols = [
    SvgPicture.asset(
      'assets/img/threads.svg',
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    ),
    const FaIcon(
      FontAwesomeIcons.reply,
      color: Colors.white,
      size: 13,
    ),
    const FaIcon(
      FontAwesomeIcons.solidUser,
      color: Colors.white,
      size: 13,
    ),
    const FaIcon(
      FontAwesomeIcons.solidHeart,
      color: Colors.white,
      size: 13,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors[type.index],
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(child: symbols[type.index]),
      ),
    );
  }
}

final List<String> activityTexts = <String>[
  'Mentioned you',
  '',
  'Followed you',
  '',
];

class ActivityListTile extends StatelessWidget {
  final String userName;
  final ActivityType type;
  final String? bodyText;
  final String? replyText;

  const ActivityListTile({
    super.key,
    required this.userName,
    required this.type,
    this.bodyText,
    this.replyText,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: Sizes.size10,
      ),
      dense: true,
      isThreeLine: true,
      // leading: UserAvatar(
      //   imageUrl: faker.image.image(random: true),
      //   floatingIcon: FloatingIconContainer(type: type),
      // ),
      title: Row(
        children: [
          Text(userName),
          Gaps.h2,
          const Text(
            '4h',
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type == ActivityType.mention || type == ActivityType.followed
                ? activityTexts[type.index]
                : bodyText!,
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
          if (type == ActivityType.reply)
            Text(
              replyText!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      trailing: type == ActivityType.followed
          ? Container(
              width: 60,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade500,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: const Center(child: Text('Following')),
            )
          : null,
    );
  }
}
