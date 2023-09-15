import 'package:assign_11/common/widgets/common_scaffold.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/features/authentication/view_models/sign_up.dart';
import 'package:assign_11/features/authentication/views/experiences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  String _password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  bool _isObsecure = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _password = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isValidated {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CommonScaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You'll need a password",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Gaps.v16,
            Text(
              "Make sure it's 8 characters or more.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87,
                  ),
            ),
            Gaps.v32,
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _controller,
                obscureText: _isObsecure,
                validator: (value) {
                  if (value!.length < 8) {
                    return "비밀번호는 8자리 이상이어야 합니다.";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => setState(() {
                          _isObsecure = !_isObsecure;
                        }),
                        icon: FaIcon(
                          _isObsecure
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                        ),
                      ),
                      if (isValidated)
                        const FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Color(0xFF53b882),
                        )
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Center(
              child: ElevatedButton(
                onPressed: isValidated
                    ? () {
                        final state = ref.read(signUpForm.notifier).state;
                        ref.read(signUpForm.notifier).state = {
                          ...state,
                          "password": _password,
                        };
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CustomExpScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
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
