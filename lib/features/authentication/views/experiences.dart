import 'package:assign_11/common/widgets/common_scaffold.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/routes.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/authentication/view_models/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomExpScreen extends ConsumerStatefulWidget {
  const CustomExpScreen({
    super.key,
  });

  @override
  ConsumerState<CustomExpScreen> createState() => CustomExpScreenState();
}

class CustomExpScreenState extends ConsumerState<CustomExpScreen> {
  bool _isChecked = false;

  void _switchChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void _onTapNext() {
    // ref.read(signUpProvider.notifier).signUp();
    context.push(RoutePath.threads);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text(
              'Customize your experience',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Gaps.v16,
            Text(
              'Track where you see Threads content across the web',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Gaps.v12,
            SizedBox(
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Threads uses this data to personalize your experience. This web browsing history will never be stored with your name,email, or phone number.',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CupertinoSwitch(
                    value: _isChecked,
                    onChanged: _switchChanged,
                  )
                ],
              ),
            ),
            Gaps.v20,
            RichText(
              text: TextSpan(
                text: 'By signing up, you agree to our ',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headlineSmall?.color,
                ),
                children: [
                  TextSpan(
                    text: 'Terms',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const TextSpan(
                    text: ', ',
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const TextSpan(text: ', '),
                  TextSpan(
                    text: 'Cookie Use',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const TextSpan(
                    text:
                        '. Threads may use your contact information, including your email address and phone number for purpose outlined in our Privacy Policy.',
                  ),
                  TextSpan(
                    text: 'Learn more',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: _isChecked && !ref.watch(signUpProvider).isLoading
                  ? _onTapNext
                  : null,
              child: Container(
                height: Sizes.size52,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32),
                  ),
                  color: _isChecked
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade400,
                ),
                child: const Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
