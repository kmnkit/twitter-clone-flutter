import 'package:assign_11/constants/globals.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/settings/view_models/settings_vm.dart';

import 'package:assign_11/features/threads/view_models/threads_view_model.dart';
import 'package:assign_11/features/threads/views/widgets/thread_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThreadsScreen extends ConsumerStatefulWidget {
  const ThreadsScreen({super.key});

  @override
  ConsumerState<ThreadsScreen> createState() => ThreadsScreenState();
}

// https://firebasestorage.googleapis.com/v0/b/nomadthread-e9e06.appspot.com/o/threads%2F${threadId}%2F$fileName?alt=media
class ThreadsScreenState extends ConsumerState<ThreadsScreen> {
  final ScrollController _controller = ScrollController();

  bool _showTopButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset > 30 && !_showTopButton) {
        setState(() {
          _showTopButton = true;
        });
      } else if (_controller.offset <= 30 && _showTopButton) {
        setState(() {
          _showTopButton = false;
        });
      }
    });
  }

  Future<void> _onRefresh() async => ref.watch(threadProvider.notifier).refresh();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthRatio = MediaQuery.sizeOf(context).width / standardWidth;
    // final heightRatio = MediaQuery.sizeOf(context).height / standardHeight;

    // 아바타 아래 아이콘 사이즈 43
    // 아바타 아래 아이콘 패딩 +4
    // 아바타 사이즈 99
    // + 아이콘 22
    // Listview 이미지간 간격 22
    // 아바타 윗쪽끝 ~ 위 간격 40
    // 이미지 윗쪽 Margin 10

    // slivers
    // CustomScrollView 안에 들어갈 element를 말함.
    var isDarkMode = ref.watch(settingsProvider).isDarkMode;
    return ref.watch(threadProvider).when(
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
          error: (Object error, StackTrace stackTrace) => Center(
            child: Text("Could not load threads: $error"),
          ),
          data: (threads) => Scaffold(
            body: Stack(
              children: [
                RefreshIndicator(
                  color: Colors.black,
                  onRefresh: _onRefresh,
                  edgeOffset: 10,
                  displacement: 40,
                  child: CustomScrollView(
                    controller: _controller,
                    // 특정한 sliver widget의 집합을 넣어야 한다.
                    slivers: [
                      SliverAppBar(
                        title: SizedBox(
                          child: SvgPicture.asset(
                            'assets/img/threads.svg',
                            width: Sizes.size96 * widthRatio,
                            height: Sizes.size96 * widthRatio,
                            colorFilter: ColorFilter.mode(
                              isDarkMode ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      SliverList.separated(
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 2,
                          height: 0,
                        ),
                        itemBuilder: (context, index) => ThreadCard(
                          threadData: threads[index],
                        ),
                        itemCount: threads.length,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
