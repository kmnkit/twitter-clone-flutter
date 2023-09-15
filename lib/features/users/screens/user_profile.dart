import 'package:assign_11/common/widgets/reaction_buttons.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/globals.dart';
import 'package:assign_11/constants/routes.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/settings/view_models/settings_vm.dart';
import 'package:assign_11/features/users/screens/edit_profile.dart';
import 'package:assign_11/features/users/screens/share_profile.dart';
import 'package:assign_11/features/users/view_models/user_view_model.dart';
import 'package:assign_11/features/users/widgets/avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return ref.watch(usersProvider).when(
        error: (Object error, StackTrace stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        data: (data) => Scaffold(
              body: SafeArea(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 1,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          leading: IconButton(
                            icon: FaIcon(
                              ref.watch(settingsProvider).isPrivate
                                  ? FontAwesomeIcons.lock
                                  : FontAwesomeIcons.earthAsia,
                            ),
                            onPressed: () {},
                          ),
                          actions: [
                            IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.instagram,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              onPressed: () => context.push(
                                RoutePath.settings,
                              ), //go는 돌아올 수 없음
                              icon: const FaIcon(
                                FontAwesomeIcons.bars,
                              ),
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Title(
                                          color: Colors.black,
                                          child: Text(
                                            data.username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Sizes.size24,
                                                ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Title(
                                              color: Colors.black,
                                              child: Text(data.username),
                                            ),
                                            Gaps.h4,
                                            Container(
                                              width: width * 229 / standardWidth,
                                              height: height * 76 / standardHeight,
                                              decoration: BoxDecoration(
                                                color: const Color(0xf5f6f6ff),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "threads.net",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Avatar(
                                      name: data.nickname,
                                      hasAvatar: data.hasAvatar,
                                      uid: data.uid,
                                    ),
                                  ],
                                ),
                                Gaps.v20,
                                Text(data.bio),
                                Gaps.v20,
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 16,
                                          child: CircleAvatar(
                                            radius: 14,
                                            backgroundImage: CachedNetworkImageProvider(
                                              "https://avatars.githubusercontent.com/u/3612017?v=4",
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 20,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 16,
                                            child: CircleAvatar(
                                              radius: 14,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                "https://avatars.githubusercontent.com/u/3612017?v=4",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gaps.h24,
                                    Text(
                                      '2 followers',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    )
                                  ],
                                ),
                                Gaps.v20,
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ProfileActionButton(
                                        text: 'Edit profile',
                                        screen: EditProfileScreen(),
                                      ),
                                      ProfileActionButton(
                                        text: 'Share profile',
                                        screen: ShareProfileScreen(),
                                      ),
                                    ],
                                  ),
                                ),
                                Gaps.v4,
                              ],
                            ),
                          ),
                        ),
                        const SliverPersistentHeader(
                          delegate: PersistentTabBar(),
                          pinned: true,
                        )
                      ];
                    },
                    body: TabBarView(
                      children: [
                        ListView.separated(
                          itemBuilder: (context, index) => Container(
                            width: width,
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 50 / standardWidth,
                              vertical: 20,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  foregroundImage: const CachedNetworkImageProvider(
                                    "https://i.namu.wiki/i/ZxU86Cj7GmLZaPBkaEW6jYSmi8FMIGsZfpaymBup-dk9SpdmYSlCHqu5ojDev0yWFl1DDk4c4WOVtfbK5tPqyw.webp",
                                  ),
                                  radius: width * 96 / standardWidth / 2,
                                ),
                                SizedBox(
                                  width: width * 24 / standardWidth,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Title(
                                            color: Colors.black,
                                            child: Text(
                                              "김성근",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text("5h"),
                                          SizedBox(
                                            width: width * 36 / 1024,
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: const FaIcon(
                                              FontAwesomeIcons.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                      ),
                                      SizedBox(
                                        height: height * 50 / standardHeight,
                                      ),
                                      const ReactionButtons(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          itemCount: 15,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        ),
                        ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 50 / standardWidth,
                                    vertical: 20,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: width * 96 / standardWidth,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              foregroundImage:
                                                  const CachedNetworkImageProvider(
                                                "https://i.namu.wiki/i/ZxU86Cj7GmLZaPBkaEW6jYSmi8FMIGsZfpaymBup-dk9SpdmYSlCHqu5ojDev0yWFl1DDk4c4WOVtfbK5tPqyw.webp",
                                              ),
                                              radius: width * 96 / standardWidth / 2,
                                            ),
                                            SizedBox(
                                                height: height * 32 / standardHeight),
                                            const VerticalDivider(
                                              width: 2,
                                              color: Colors.black,
                                              thickness: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 24 / standardWidth,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Title(
                                                  color: Colors.black,
                                                  child: Text(
                                                    "김성근",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Text("5h"),
                                                SizedBox(
                                                  width: width * 36 / 1024,
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: const FaIcon(
                                                    FontAwesomeIcons.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Text(
                                              "돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.돈 받으면 프로다.",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 5,
                                            ),
                                            SizedBox(
                                              height: height * 34 / standardHeight,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade400,
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    width * 48 / standardWidth),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          foregroundImage:
                                                              CachedNetworkImageProvider(
                                                            "https://search.pstatic.net/common?type=b&size=216&expire=1&refresh=true&quality=100&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F36%2F202103302005208691.png",
                                                          ),
                                                          radius: 16,
                                                        ),
                                                        SizedBox(
                                                            width: width *
                                                                24 /
                                                                standardWidth),
                                                        Title(
                                                          color: Colors.black,
                                                          child: Text(
                                                            "송승준",
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .titleSmall,
                                                            overflow: TextOverflow.clip,
                                                          ),
                                                        ),
                                                        Gaps.h4,
                                                        const FaIcon(
                                                          FontAwesomeIcons
                                                              .solidCircleCheck,
                                                          color: Colors.blue,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          height * 32 / standardHeight,
                                                    ),
                                                    const Text("저도 경기 뛰고 싶습니다."),
                                                    SizedBox(
                                                      height:
                                                          height * 64 / standardHeight,
                                                    ),
                                                    Text(
                                                      "256 replies",
                                                      style: TextStyle(
                                                        color: Colors.grey.shade600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 50 / standardHeight,
                                            ),
                                            const ReactionButtons(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 50 / standardWidth,
                                    vertical: 20,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // 아바다 박스
                                      // CircleAvatar(
                                      //   foregroundImage: CachedNetworkImageProvider(
                                      //     faker.image.image(random: true),
                                      //   ),
                                      //   radius: width * 96 / standardWidth / 2,
                                      // ),
                                      SizedBox(
                                        width: width * 24 / standardWidth,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Title(
                                                  color: Colors.black,
                                                  child: const Text(
                                                    'torch_327',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Text("5h"),
                                                SizedBox(
                                                  width: width * 36 / 1024,
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: const FaIcon(
                                                    FontAwesomeIcons.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Text(
                                              'See you there!!See you there!!See you there!!See you there!!',
                                            ),
                                            SizedBox(
                                              height: height * 48 / standardHeight,
                                            ),
                                            const ReactionButtons(),
                                            SizedBox(
                                              height: height * 48 / standardHeight,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  const PersistentTabBar();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade400, width: 0.5),
        ),
      ),
      child: const TabBar(
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.black,
        labelPadding: EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        tabs: [
          Tab(
            text: "Threads",
          ),
          Tab(
            text: "Replies",
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class ProfileActionButton extends StatelessWidget {
  final Widget screen;
  final String text;
  const ProfileActionButton({
    super.key,
    required this.text,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        width: width * 502 / 1125,
        height: height * 107 / 2436,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  _onTap(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.indigo,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text(
            'Title!!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
