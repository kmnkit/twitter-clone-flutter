import 'package:assign_11/features/authentication/repos/authentication_repo.dart';
import 'package:assign_11/features/authentication/view_models/sign_in.dart';
import 'package:assign_11/features/authentication/view_models/sign_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInOutButton extends ConsumerStatefulWidget {
  const SignInOutButton({super.key});

  @override
  ConsumerState<SignInOutButton> createState() => SignInOutButtonState();
}

class SignInOutButtonState extends ConsumerState<SignInOutButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final snackBar = SnackBar(
          content: Text("${ref.read(authRepo).isLoggedIn ? "로그아웃" : "로그인"} 되었습니다."),
          action: SnackBarAction(
            label: "OK",
            onPressed: () {},
          ),
        );
        if (ref.read(authRepo).isLoggedIn) {
          ref.read(signOutProvider.notifier).signOut();
        } else {
          ref.read(signInProvider.notifier).signIn(
                "k900327s@gmail.com",
                "kang7944",
                context,
              );
        }
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Text(ref.read(authRepo).isLoggedIn ? "로그아웃" : "로그인"),
    );
  }
}
