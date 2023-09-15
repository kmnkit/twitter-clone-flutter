import 'dart:io';

import 'package:assign_11/constants/globals.dart';
import 'package:assign_11/features/users/view_models/avatar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends ConsumerWidget {
  final String name, uid;
  final double? radius;

  final bool hasAvatar;
  const Avatar({
    super.key,
    this.radius = 100,
    required this.name,
    required this.uid,
    required this.hasAvatar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;

    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: CircleAvatar(
        radius: radius! * MediaQuery.sizeOf(context).width / standardWidth,
        foregroundImage: isLoading
            ? null
            : hasAvatar
                ? NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/nomadthread-e9e06.appspot.com/o/avatars%2F$uid?alt=media',
                  )
                : null,
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : Text((name != "") ? name[0] : "A"),
      ),
    );
  }

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }
}
