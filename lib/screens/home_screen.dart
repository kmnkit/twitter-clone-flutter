import 'package:assign_11/common/widgets/common_scaffold.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/widgets/auth_button.dart';
import 'package:assign_11/screens/sign_up/screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "See what's happening in the world right now!",
                style: TextStyle(
                  fontSize: Sizes.size44,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          AuthButton(
            func: (context) {},
            icon: Image.network(
              'https://img.icons8.com/?size=384&id=17949&format=png',
              width: Sizes.size32,
            ),
            text: 'Continue with Google',
          ),
          Gaps.v12,
          AuthButton(
            func: (context) {},
            icon: const FaIcon(
              FontAwesomeIcons.apple,
              size: Sizes.size32,
            ),
            text: 'Continue with Apple',
          ),
          Gaps.v16,
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey.shade400,
                ),
              ),
              Gaps.h16,
              const Text('or'),
              Gaps.h16,
              Expanded(
                child: Divider(
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          Gaps.v16,
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ),
              );
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: Sizes.size52,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(
                  Radius.circular(48),
                ),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: const Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Gaps.v24,
          RichText(
            text: TextSpan(
              text: 'By signing up, you agree to our ',
              style: TextStyle(
                color: Theme.of(context).textTheme.headlineSmall?.color,
              ),
              children: [
                TextSpan(
                  text: 'Terms',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                const TextSpan(
                  text: ', ',
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                const TextSpan(text: ', '),
                TextSpan(
                  text: 'Cookie Use',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
          Gaps.v32,
        ],
      ),
      bottomBar: BottomAppBar(
        elevation: 0,
        child: Center(
          child: RichText(
            text: TextSpan(
              text: 'Have an account already? ',
              style: TextStyle(
                color: Theme.of(context).textTheme.headlineSmall?.color,
              ),
              children: [
                TextSpan(
                  text: 'Log in',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
