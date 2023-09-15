import 'dart:io';

import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/authentication/repos/authentication_repo.dart';
import 'package:assign_11/features/threads/view_models/post_thread_view_model.dart';

import 'package:assign_11/features/users/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PostThread extends ConsumerStatefulWidget {
  const PostThread({
    super.key,
  });

  @override
  ConsumerState<PostThread> createState() => PostThreadState();
}

class PostThreadState extends ConsumerState<PostThread> {
  String? threadText;
  List<File> images = [];
  List<String> threads = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.8;
    final user = ref.read(authRepo).user!;
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 맨 윗부분
            Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              clipBehavior: Clip.hardEdge,
              direction: Axis.horizontal,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: const SizedBox(child: Text('Cancel')),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Center(
                    child: Text(
                      'New Thread',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                const Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(),
                ),
              ],
            ),
            const Divider(
              height: Sizes.size32,
            ),
            WriteContainer(
              username: user.displayName ?? "Anonymous",
              isCurrent: true,
              valueChanged: (value) {
                setState(() {
                  threadText = value;
                });
              },
              uid: user.uid,
              onImagesPicked: (newImages) {
                setState(() {
                  images.addAll(newImages);
                });
              },
            ),
            Gaps.v16,
            if (images.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                              images[index],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              images.remove(images[index]);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              fixedSize: const Size.fromWidth(20),
                              padding: const EdgeInsets.all(1),
                              backgroundColor: Colors.black.withOpacity(0.6)),
                          child: const FaIcon(
                            FontAwesomeIcons.x,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => Gaps.h20,
                  itemCount: images.length,
                ),
              ),
            Gaps.v16,
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Opacity(
                  opacity: 0.5,
                  child: Avatar(
                    name: user.displayName ?? "Anonymous",
                    uid: user.uid,
                    hasAvatar: true,
                    radius: 40,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Anyone can reply'),
                TextButton(
                  onPressed: () async {
                    if (threadText == null && images.isEmpty) {
                      final snackBar = SnackBar(
                        content: const Text("글 작성 또는 이미지 업로드가 필요합니다."),
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    await ref.watch(postThreadProvider.notifier).postNewThread(
                          threadText,
                          images,
                        );
                    context.pop();
                  },
                  child: const Text('Post'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WriteContainer extends StatefulWidget {
  final String username, uid;
  final bool isCurrent;
  final ValueChanged<String> valueChanged;
  final Function(List<File>) onImagesPicked;

  const WriteContainer({
    super.key,
    required this.uid,
    required this.username,
    required this.isCurrent,
    required this.valueChanged,
    required this.onImagesPicked,
  });

  @override
  State<WriteContainer> createState() => _WriteContainerState();
}

class _WriteContainerState extends State<WriteContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Avatar(
                    name: widget.username,
                    uid: widget.uid,
                    hasAvatar: true,
                    radius: 60,
                  ),
                  const Flexible(
                    child: VerticalDivider(
                      width: 1,
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                ],
              ),
              Gaps.h8,
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                    ),
                    // 쓰레드 내용 쓰는 곳
                    TextField(
                      minLines: null,
                      maxLines: null,
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: "Start a thread...",
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: Sizes.size10,
                        ),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      showCursor: true,
                      onChanged: (value) => widget.valueChanged(value),
                    ),
                    Gaps.v16,
                    GestureDetector(
                      onTap: _onTap,
                      child: FaIcon(
                        widget.isCurrent ? FontAwesomeIcons.paperclip : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onTap() async {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const ImageUploadScreen(),
    // ));
    final List<XFile> xfiles = await ImagePicker().pickMultiImage(
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfiles.isNotEmpty) {
      List<File> newImages = [];
      for (var i = 0; i < xfiles.length; i++) {
        newImages.add(File(xfiles[i].path));
      }
      widget.onImagesPicked(newImages);
    }
  }
}
