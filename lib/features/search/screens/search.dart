import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      _text = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.black, child: const Text('Search')),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CupertinoSearchTextField(),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    isThreeLine: true,
                    // leading: CircleAvatar(
                    //   backgroundImage: CachedNetworkImageProvider(
                    //     faker.image.image(random: true),
                    //   ),
                    // ),
                    title: const Text(
                      "Temp",
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Temp",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        const Text(
                          '10K followers',
                        ),
                      ],
                    ),
                    trailing: const UserFollowChip(),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: 10),
          ),
        ],
      ),
    );
  }
}

class UserFollowChip extends StatefulWidget {
  const UserFollowChip({
    super.key,
  });

  @override
  State<UserFollowChip> createState() => _UserFollowChipState();
}

class _UserFollowChipState extends State<UserFollowChip> {
  bool _isFollowing = false;
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: () {
        setState(() {
          _isFollowing = !_isFollowing;
        });
      },
      label: Text(
        _isFollowing ? 'Follow' : 'Unfollow',
      ),
    );
  }
}
