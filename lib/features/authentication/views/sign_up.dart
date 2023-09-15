import 'package:assign_11/common/widgets/common_scaffold.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/authentication/view_models/sign_up.dart';
import 'package:assign_11/features/authentication/views/password.dart';
import 'package:assign_11/features/authentication/widgets/sign_up_form_field.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  String _name = "";
  String _mail = "";
  String _birthday = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _onTapNext(context) {
    ref.read(signUpForm.notifier).state = {"username": _name, "email": _mail};
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // pushAndRemoveUntil은 이 화면 전의 모든 화면을 삭제해 버린다.

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PasswordScreen(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _setTextFieldDate(maximumDate);

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    _addressController.addListener(() {
      setState(() {
        _mail = _addressController.text;
      });
    });
    _birthdayController.addListener(() {
      setState(() {
        _birthday = _birthdayController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  bool _nameValidated = false;
  bool _addressValidated = false;

  DateTime maximumDate = DateTime(
    DateTime.now().year - 18,
    DateTime.now().month,
    DateTime.now().day,
  );

  void _onLeadingTap(BuildContext context) => Navigator.of(context).pop();

  String? _validateUsername(String? value) {
    final RegExp usernameRegex = RegExp(r'^[a-z0-9\s]{6,20}$');
    final isValid = usernameRegex.hasMatch(value ?? '');
    if (isValid) {
      setState(() {
        _nameValidated = true;
      });
      return null;
    }
    setState(() {
      _nameValidated = false;
    });
    return "Username은 6~20자의 소문자 및 공백만 허용됩니다.";
  }

  String? _validateEmail(String? value) {
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    final isValid = regExp.hasMatch(value ?? '');
    if (isValid) {
      setState(() {
        _addressValidated = true;
      });
      return null;
    }
    setState(() {
      _addressValidated = false;
    });
    return "이메일 형식에 맞게 입력해 주세요!";
  }

  String? _validateBirthday(String? value) {
    return null;
  }

  void _setTextFieldDate(DateTime date) {
    _birthdayController.value = TextEditingValue(
      text: DateFormat('MMMM d, yyyy').format(date),
    );
  }

  void _showDatePicker(BuildContext context) => showCupertinoModalPopup(
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          color: CupertinoColors.white,
          height: 300,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextFieldDate,
            maximumYear: DateTime.now().year - 18,
            initialDateTime: maximumDate,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: AppBar(
        leadingWidth: Sizes.size64,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: Sizes.size12,
            top: Sizes.size12,
          ),
          child: GestureDetector(
            onTap: () => _onLeadingTap(context),
            child: const Text('Cancel'),
          ),
        ),
        title: const SizedBox(
          width: Sizes.size52,
          height: Sizes.size52,
          child: FaIcon(
            FontAwesomeIcons.twitter,
            color: Color(0xFF4d98e9),
            size: Sizes.size40,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v48,
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: Sizes.size24,
                ),
              ),
              Gaps.v48,
              SignUpFormField(
                controller: _nameController,
                hintText: "Name",
                validator: _validateUsername,
                keyboardType: TextInputType.name,
              ),
              Gaps.v32,
              SignUpFormField(
                controller: _addressController,
                hintText: "Phone number or email address",
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              Gaps.v32,
              TextFormField(
                controller: _birthdayController,
                readOnly: true,
                onTap: () => _showDatePicker(context),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                validator: _validateBirthday,
                decoration: InputDecoration(
                  hintText: "Date of birth",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                  suffixIcon: _birthday.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              color: Colors.green.shade500,
                            ),
                          ],
                        )
                      : Container(),
                ),
              ),
              Gaps.v12,
              RichText(
                text: TextSpan(
                  text: 'By signing up, you agree to the ',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headlineSmall?.color,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const TextSpan(
                      text: ' and ',
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const TextSpan(text: ', including '),
                    TextSpan(
                      text: 'Cookie Use',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const TextSpan(
                        text:
                            '. Threads may use your contact information, including your email address and phone number for purpose outlined in our Privacy Policy.'),
                    TextSpan(
                      text: 'Learn more',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const TextSpan(
                        text:
                            'Others will be able to find you by email or phone number, when provided, unless you choose otherwise '),
                    TextSpan(
                      text: 'here',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const TextSpan(text: '.')
                  ],
                ),
              )
              // state[""]
              //     ? RichText(
              //         text: TextSpan(
              //           text: 'By signing up, you agree to the ',
              //           style: TextStyle(
              //             color: Theme.of(context).textTheme.headlineSmall?.color,
              //           ),
              //           children: [
              //             TextSpan(
              //               text: 'Terms of Service',
              //               style: TextStyle(color: Theme.of(context).primaryColor),
              //             ),
              //             const TextSpan(
              //               text: ' and ',
              //             ),
              //             TextSpan(
              //               text: 'Privacy Policy',
              //               style: TextStyle(color: Theme.of(context).primaryColor),
              //             ),
              //             const TextSpan(text: ', including '),
              //             TextSpan(
              //               text: 'Cookie Use',
              //               style: TextStyle(color: Theme.of(context).primaryColor),
              //             ),
              //             const TextSpan(
              //                 text:
              //                     '. Threads may use your contact information, including your email address and phone number for purpose outlined in our Privacy Policy.'),
              //             TextSpan(
              //               text: 'Learn more',
              //               style: TextStyle(color: Theme.of(context).primaryColor),
              //             ),
              //             const TextSpan(
              //                 text:
              //                     'Others will be able to find you by email or phone number, when provided, unless you choose otherwise '),
              //             TextSpan(
              //               text: 'here',
              //               style: TextStyle(color: Theme.of(context).primaryColor),
              //             ),
              //             const TextSpan(text: '.')
              //           ],
              //         ),
              //       )
              //     : const Text(
              //         'This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.',
              //         style: TextStyle(
              //           fontSize: Sizes.size18,
              //         ),
              //       ),,
              ,
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () => _onTapNext(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: (true || (_nameValidated && _addressValidated))
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade500,
                    ),
                    width: true ? MediaQuery.sizeOf(context).width : Sizes.size80,
                    height: Sizes.size52,
                    child: const Center(
                      child: Text(
                        false ? 'Sign up' : 'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
