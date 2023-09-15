import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/globals.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/authentication/view_models/sign_in.dart';
import 'package:assign_11/features/settings/view_models/settings_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};
  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(signInProvider.notifier).signIn(
              formData["email"]!,
              formData["password"]!,
              context,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = ref.watch(settingsProvider).isDarkMode;
    final widthRatio = MediaQuery.sizeOf(context).width / standardWidth;
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue == null) return;
                  formData["email"] = newValue;
                },
              ),
              Gaps.v16,
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                validator: (value) {
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue == null) return;
                  formData["password"] = newValue;
                },
              ),
              Gaps.v28,
              TextButton(
                  onPressed: ref.watch(signInProvider).isLoading ? null : _onSubmitTap,
                  child: const Text("Log In"))
            ],
          ),
        ),
      ),
    );
  }
}
