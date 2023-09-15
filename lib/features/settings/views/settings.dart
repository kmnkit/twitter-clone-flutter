import 'package:assign_11/constants/routes.dart';
import 'package:assign_11/features/authentication/repos/authentication_repo.dart';
import 'package:assign_11/features/settings/view_models/settings_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

const List<Widget> brightnessIcons = <Widget>[
  FaIcon(FontAwesomeIcons.solidSun),
  FaIcon(FontAwesomeIcons.solidMoon),
];

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isLogOutProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          ToggleButtons(
            direction: Axis.horizontal,
            isSelected:
                ref.watch(settingsProvider).isDarkMode ? [false, true] : [true, false],
            onPressed: (index) =>
                ref.read(settingsProvider.notifier).setDarkMode(index == 1),
            selectedColor: Colors.amber.shade700,
            children: brightnessIcons,
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Expanded(
            child: ListView(children: [
              const ListTile(
                title: Text("Follow and invite friends"),
                leading: Image(
                  image: AssetImage(
                    "assets/img/follow.png",
                  ),
                  width: 24,
                ),
              ),
              const ListTile(
                title: Text("Notifications"),
                leading: FaIcon(
                  FontAwesomeIcons.bell,
                  size: 24,
                ),
              ),
              const ListTile(
                title: Text("Your likes"),
                leading: FaIcon(FontAwesomeIcons.heart),
              ),
              ListTile(
                title: const Text("Privacy"),
                leading: const Image(
                  image: AssetImage("assets/img/lock.png"),
                  width: 24,
                  fit: BoxFit.cover,
                ),
                onTap: () => context.push(RoutePath.privacySetting),
              ),
              const ListTile(
                title: Text("Accessibility"),
                leading: Image(
                  image: AssetImage("assets/img/accessibility.png"),
                  width: 24,
                ),
              ),
              const ListTile(
                title: Text("Account"),
                leading: FaIcon(FontAwesomeIcons.circleUser),
              ),
              const ListTile(
                title: Text("Help"),
                leading: FaIcon(FontAwesomeIcons.circleQuestion),
              ),
              const ListTile(
                title: Text("About"),
                leading: Image(
                  image: AssetImage("assets/img/info.png"),
                  width: 24,
                  fit: BoxFit.cover,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                title: const Text("Logout"),
                leading: const FaIcon(
                  FontAwesomeIcons.rightFromBracket,
                ),
                trailing:
                    _isLogOutProcessing ? const CupertinoActivityIndicator() : null,
                onTap: () {
                  setState(() {
                    _isLogOutProcessing = !_isLogOutProcessing;
                  });

                  showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: const Text("Log out of Threads?"),
                        actions: Theme.of(context).platform == TargetPlatform.iOS
                            ? [
                                Column(
                                  children: [
                                    CupertinoDialogAction(
                                        isDestructiveAction: true,
                                        child: const Text("Log out"),
                                        onPressed: () {
                                          ref.read(authRepo).signOut();
                                          context.go(RoutePath.threads);
                                        }),
                                    CupertinoDialogAction(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        setState(() {
                                          _isLogOutProcessing = false;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ]
                            : [
                                Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLogOutProcessing = false;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ref.read(authRepo).signOut();
                                        context.go(RoutePath.threads);
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              ],
                      );
                    },
                  );
                },
              )
            ]),
          ),
        ],
      ),
    );
  }
}
          // CloseButton(),
