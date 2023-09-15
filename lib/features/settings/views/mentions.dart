import 'package:assign_11/features/settings/view_models/settings_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentionsScreen extends ConsumerWidget {
  const MentionsScreen({super.key});

  void _onChanged(WidgetRef ref, int value) =>
      ref.read(settingsProvider.notifier).setAllowMention(value);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentions'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Title(
                color: Colors.black,
                child: const Text(
                  "Allow @mentions from",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                  "Choose who can @mention you to link your profile in their threads, replies or bio. When people try to @mention you, they'll see you don't allow @mentions."),
              Expanded(
                child: ListView(
                  children: [
                    RadioListTile.adaptive(
                      title: const Text("Everyone"),
                      value: 0,
                      groupValue: ref.watch(settingsProvider).allowMention,
                      onChanged: (value) => _onChanged(ref, value!),
                    ),
                    RadioListTile.adaptive(
                      title: const Text("Profiles you follow"),
                      value: 1,
                      groupValue: ref.watch(settingsProvider).allowMention,
                      onChanged: (value) => _onChanged(ref, value!),
                    ),
                    RadioListTile.adaptive(
                      title: const Text("No one"),
                      value: 2,
                      groupValue: ref.watch(settingsProvider).allowMention,
                      onChanged: (value) => _onChanged(ref, value!),
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
