import 'package:assign_11/constants/routes.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/settings/view_models/settings_vm.dart';
import 'package:assign_11/features/settings/views/muted.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class PrivacyScreen extends ConsumerWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  // provider -> riverpod
                  value: ref.read(settingsProvider).isPrivate,
                  onChanged: (value) {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: Text(
                            // provider -> riverpod
                            // context.read<PrivacyConfigViewModel>().isPrivate
                            "Switch to ${ref.read(settingsProvider).isPrivate ? 'public' : 'private'} account?",
                          ),
                          content: Text(
                            value
                                ? "Only approved followers will be able to see and interact with your content."
                                : "Anyone on or off Threads can see and interact with your content.",
                            maxLines: 3,
                          ),
                          actions: Theme.of(context).platform == TargetPlatform.iOS
                              ? [
                                  Column(
                                    children: [
                                      CupertinoDialogAction(
                                        isDestructiveAction: true,
                                        child: const Text("OK"),
                                        onPressed: () {
                                          ref
                                              .read(settingsProvider.notifier)
                                              .setPrivacy(value);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      const Divider(),
                                      CupertinoDialogAction(
                                        child: const Text("Cancel"),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                ]
                              : [
                                  Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(settingsProvider.notifier)
                                              .setPrivacy(value);
                                        },
                                        child: const Text("OK"),
                                      ),
                                      const Divider(),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                    ],
                                  ),
                                ],
                        );
                      },
                    );
                  },
                  title: const Text("Private profile"),
                  secondary: Image(
                    image: AssetImage(
                      "assets/img/${ref.read(settingsProvider).isPrivate ? "lock" : "unlock"}.png",
                    ),
                    width: Sizes.size24,
                    height: Sizes.size24,
                  ),
                ),
                ListTile(
                  title: const Text("Mentions"),
                  leading: const Image(
                    image: AssetImage(
                      "assets/img/mention.png",
                    ),
                    width: Sizes.size24,
                    height: Sizes.size24,
                    fit: BoxFit.cover,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (ref.watch(settingsProvider).allowMention == 0)
                        const Text("Everyone")
                      else if (ref.watch(settingsProvider).allowMention == 1)
                        const Text("Following")
                      else if (ref.watch(settingsProvider).allowMention == 2)
                        const Text("No One")
                      else
                        const Text("Everyone"),
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                  onTap: () => context.push(RoutePath.allowMentionsSetting),
                ),
                ListTile(
                  title: const Text("Muted"),
                  leading: const Image(
                    image: AssetImage(
                      "assets/img/muted.png",
                    ),
                    width: Sizes.size24,
                    height: Sizes.size24,
                    fit: BoxFit.cover,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MutedScreen(),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text("Hidden Words"),
                  leading: const Image(
                    image: AssetImage(
                      "assets/img/hidden.png",
                    ),
                    width: Sizes.size24,
                    height: Sizes.size24,
                    fit: BoxFit.cover,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text("Profiles you follow"),
                  leading: const Image(
                    image: AssetImage(
                      "assets/img/users.png",
                    ),
                    width: Sizes.size24,
                    height: Sizes.size24,
                    fit: BoxFit.cover,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 1,
                ),
                ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  onTap: () {},
                  title: const Text("Other privacy settings"),
                  subtitle: const Text(
                    "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
                    maxLines: 3,
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.upRightFromSquare,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
                ListTile(
                  title: const Text("Blocked Profiles"),
                  leading: const FaIcon(FontAwesomeIcons.circleXmark),
                  trailing: FaIcon(
                    FontAwesomeIcons.upRightFromSquare,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
                ListTile(
                  title: const Text("Hide likes"),
                  leading: const FaIcon(FontAwesomeIcons.heartCrack),
                  trailing: FaIcon(
                    FontAwesomeIcons.upRightFromSquare,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
