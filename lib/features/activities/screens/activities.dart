import 'package:assign_11/constants/activity_types.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/activities/widgets/activity_list_tile.dart';

import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({super.key});

  static final _tabLabels = [
    'All',
    'Replies',
    'Mentions',
    'Followers',
    'Favourites',
  ];

  static final List<Tab> _tabs = List.generate(
    _tabLabels.length,
    (index) => Tab(
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: Center(child: Text(_tabLabels[index])),
      ),
    ),
  );

  final List<ActivityListTile> activities = [
    const ActivityListTile(
      userName: 'john_mobbin',
      type: ActivityType.mention,
      bodyText: "Here's a thread you should follow if you love botany @jane_mobbin",
    ),
    const ActivityListTile(
      userName: 'john_mobbin',
      type: ActivityType.reply,
      bodyText: "Starting out my gardening club with throw the error",
      replyText: "Count me in!",
    ),
    const ActivityListTile(
      userName: 'the.plantdads',
      type: ActivityType.followed,
    ),
    const ActivityListTile(
      userName: 'the.plantdads',
      type: ActivityType.favourite,
      bodyText: 'Definitely broken! 🧵 👀 🌱',
    ),
    const ActivityListTile(
      userName: 'theberryjungle',
      type: ActivityType.favourite,
      bodyText: '🧵 👀 🌱',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final filteredReplies =
        activities.where((activity) => activity.type == ActivityType.reply).toList();
    final filteredMentions =
        activities.where((activity) => activity.type == ActivityType.mention).toList();
    final filteredFollowers =
        activities.where((activity) => activity.type == ActivityType.followed).toList();
    final filteredFavourites = activities
        .where((activity) => activity.type == ActivityType.favourite)
        .toList();
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.black,
            child: const Text('Activity'),
          ),
          centerTitle: false,
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            labelPadding: const EdgeInsets.symmetric(
              horizontal: Sizes.size4,
            ),
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TabBarView(
            children: [
              ListView.separated(
                itemBuilder: (context, index) => activities[index],
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 5,
              ),
              ListView.separated(
                itemBuilder: (context, index) => filteredReplies[index],
                separatorBuilder: (context, index) => const Divider(),
                itemCount: filteredReplies.length,
              ),
              ListView.separated(
                itemBuilder: (context, index) => filteredMentions[index],
                separatorBuilder: (context, index) => const Divider(),
                itemCount: filteredMentions.length,
              ),
              ListView.separated(
                itemBuilder: (context, index) => filteredFollowers[index],
                separatorBuilder: (context, index) => const Divider(),
                itemCount: filteredFollowers.length,
              ),
              ListView.separated(
                itemBuilder: (context, index) => filteredFavourites[index],
                separatorBuilder: (context, index) => const Divider(),
                itemCount: filteredFavourites.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
