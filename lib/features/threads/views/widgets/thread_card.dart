import 'package:assign_11/common/widgets/reaction_buttons.dart';
import 'package:assign_11/constants/globals.dart';
import 'package:assign_11/features/threads/models/thread.dart';
import 'package:assign_11/features/threads/view_models/delete_thread_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class ThreadCard extends ConsumerWidget {
  const ThreadCard({
    super.key,
    required this.threadData,
  });

  final Thread threadData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widthRatio = MediaQuery.sizeOf(context).width / standardWidth;
    final heightRatio = MediaQuery.sizeOf(context).height / standardHeight;
    return Card(
      clipBehavior: Clip.none,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.only(
          top: heightRatio * 40,
          bottom: heightRatio * 40,
          left: widthRatio * 32,
          right: widthRatio * 44,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        foregroundImage: CachedNetworkImageProvider(
                            "https://firebasestorage.googleapis.com/v0/b/nomadthread-e9e06.appspot.com/o/avatars%2F${threadData.creatorUid}?alt=media"),
                        child: Text(
                          threadData.creator[0],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Container(
                              width: 43 * widthRatio,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 3,
                                  )
                                ],
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: VerticalDivider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                      indent: 4,
                      endIndent: 4,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 23 * widthRatio,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 작성 정보 Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          threadData.creator,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 22 * widthRatio,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.blue,
                          size: 40 * widthRatio,
                        ),
                        const Spacer(),
                        Text(
                          timeago.format(
                            DateTime.fromMillisecondsSinceEpoch(
                              threadData.created,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 22 * widthRatio,
                        ),
                        PopupMenuButton(
                          initialValue: 0,
                          itemBuilder: (context) {
                            return <PopupMenuEntry>[
                              PopupMenuItem(
                                value: 0,
                                child: const Text("삭제"),
                                onTap: () => showAdaptiveDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog.adaptive(
                                      title: const Text("삭제하시겠습니까?"),
                                      actions: Theme.of(context).platform ==
                                              TargetPlatform.iOS
                                          ? [
                                              Column(
                                                children: [
                                                  CupertinoDialogAction(
                                                    isDestructiveAction: true,
                                                    child: const Text("삭제"),
                                                    onPressed: () {
                                                      ref
                                                          .watch(deleteThreadProvider
                                                              .notifier)
                                                          .deleteThread(threadData.id);
                                                      context.pop();
                                                    },
                                                  ),
                                                  CupertinoDialogAction(
                                                    child: const Text("Cancel"),
                                                    onPressed: () => context.pop(),
                                                  ),
                                                ],
                                              ),
                                            ]
                                          : [
                                              Column(
                                                children: [
                                                  TextButton(
                                                    onPressed: () => context.pop(),
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      ref
                                                          .watch(deleteThreadProvider
                                                              .notifier)
                                                          .deleteThread(threadData.id);
                                                      context.pop();
                                                    },
                                                    child: const Text("OK"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    // 작성 내용
                    Text(threadData.text),
                    SizedBox(
                      height: 20 * heightRatio,
                    ),
                    if (threadData.imageUrls.isNotEmpty)
                      SizedBox(
                        height: 300 * heightRatio,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Image(
                            image: CachedNetworkImageProvider(
                              threadData.imageUrls[index],
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 20 * widthRatio),
                          itemCount: threadData.imageUrls.length,
                        ),
                      ),
                    SizedBox(
                      height: 30 * heightRatio,
                    ),
                    const ReactionButtons(),
                    SizedBox(
                      height: 30 * heightRatio,
                    ),
                    Text(
                      "${threadData.replies} replies ・ ${threadData.likes} likes",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
