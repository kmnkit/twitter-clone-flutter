import 'package:assign_11/common/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class ReportTilesModal extends StatelessWidget {
  ReportTilesModal({super.key});

  final List<ListTile> tiles = <ListTile>[
    const ListTile(
      title: Center(
        child: Text(
          "Report",
          // style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //       fontWeight: FontWeight.w700,
          //     ),
        ),
      ),
    ),
    const ListTile(
      title: Text(
        'Why are you reporting this thread?',
        // style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //       fontWeight: FontWeight.w700,
        //     ),
      ),
      subtitle: Text(
        "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
      ),
    ),
    ReportListTile(
      text: "👎 I just don't like it",
      onTapFunction: () async {},
    ),
    ReportListTile(
      text: "⽖ It's unlawful content under NetzDG",
      onTapFunction: () async {},
    ),
    ReportListTile(
      text: "🫤 It's spam",
      onTapFunction: () async {},
    ),
    ReportListTile(
      text: "🤬 Hate speech or symbols",
      onTapFunction: () async {},
    ),
    ReportListTile(
      text: "☠️ Nudity or sexual activity",
      onTapFunction: () async {},
    ),
    ReportListTile(
      text: "👊 Violation",
      onTapFunction: () async {},
    ),
  ];

  @override
  Widget build(BuildContext context) => ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList(),
      );
}
