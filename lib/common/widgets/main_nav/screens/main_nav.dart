import 'package:assign_11/constants/globals.dart';
import 'package:assign_11/features/activities/screens/activities.dart';
import 'package:assign_11/features/search/screens/search.dart';
import 'package:assign_11/features/threads/views/threads.dart';
import 'package:assign_11/features/users/screens/user_profile.dart';
import 'package:assign_11/features/threads/views/widgets/post_thread.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class Destination {
  final int index;
  final IconData icon;

  Destination(
    this.index,
    this.icon,
  );
}

class MainNavigationScreen extends ConsumerStatefulWidget {
  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  ConsumerState<MainNavigationScreen> createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  final List<String> _tabs = [
    "threads",
    "search",
    "post",
    "activity",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  static List<Destination> destinations = <Destination>[
    Destination(0, FontAwesomeIcons.house),
    Destination(1, FontAwesomeIcons.magnifyingGlass),
    Destination(2, FontAwesomeIcons.penToSquare),
    Destination(3, FontAwesomeIcons.heart),
    Destination(4, FontAwesomeIcons.user),
  ];

  late final List<Widget> destinationViews;

  void _onDestinationSelected(int index) {
    context.go("/${_tabs[index]}");
    if (index != 2) {
      setState(
        () {
          _selectedIndex = index;
        },
      );
    } else {
      showModalBottomSheet(
        useSafeArea: false,
        context: context,
        builder: (context) => const PostThread(),
      );
    }

    // return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const ThreadsScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const SearchScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: ActivityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        height: 150 * MediaQuery.sizeOf(context).height / standardHeight,
        destinations: destinations
            .map(
              (destination) => NavigationDestination(
                icon: FaIcon(
                  destination.icon,
                  color: Colors.grey.shade400,
                ),
                selectedIcon: FaIcon(
                  destination.icon,
                  color: Colors.black,
                ),
                label: '',
              ),
            )
            .toList(),
        elevation: 0,
      ),
    );
  }
}
