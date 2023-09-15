import 'package:assign_11/common/widgets/common_scaffold.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/features/authentication/views/password.dart';
import 'package:assign_11/features/authentication/widgets/verify_number_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerificateScreen extends StatefulWidget {
  final String email;
  const VerificateScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerificateScreen> createState() => _VerificateScreenState();
}

class _VerificateScreenState extends State<VerificateScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  final int correctCode = 230824;

  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<int?> _values = List.generate(6, (index) => null);

  bool _formValidated = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(
        () => _updateValue(
          i,
          _controllers[i].text,
        ),
      );
    }
    _focusNodes[5].addListener(() {
      if (!_focusNodes[5].hasFocus) {
        setState(() {
          _formValidated = isFormValid;
        });
      }
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const PasswordScreen(),
            ),
            (route) => false,
          );
        }
      });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focus in _focusNodes) {
      focus.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  void _updateValue(int index, String text) {
    if (text.isNotEmpty) {
      _values[index] = int.parse(text);
    }
    setState(() {});
  }

  bool get isFormValid {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formValidated = validateCode();
    } else {
      _formValidated = false;
    }
    return _formValidated;
  }

  bool validateCode() {
    setState(() {
      if (_values.contains(null)) _formValidated = false;
      final int code = int.parse(_values.join());
      _formValidated = correctCode == code;
    });
    return _formValidated;
  }

  _onNext() {
    setState(() {
      _animationController.forward(from: _animationController.value);
    });
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
              'We sent you a code',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Gaps.v16,
            Text(
              'Enter it below to verify',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              widget.email,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gaps.v32,
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return VerificationNumberField(
                      controller: _controllers[index],
                      currentNode: _focusNodes[index],
                      nextNode: index < 5 ? _focusNodes[(index) + 1] : null,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Gaps.h16,
                  itemCount: 6,
                ),
              ),
            ),
            Gaps.v4,
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  for (var controller in _controllers) {
                    controller.clear();
                  }
                },
                child: const Text('Clear'),
              ),
            ),
            Gaps.v16,
            _formValidated
                ? const Center(
                    child: FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      color: Color(0xFF53b882),
                    ),
                  )
                : Container(),
            const Expanded(
              child: SizedBox(),
            ),
            Text(
              "Didn't receive email?",
              style: TextStyle(
                color: Colors.blue.shade600,
              ),
            ),
            Gaps.v16,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(52, 52),
              ),
              onPressed: _formValidated ? _onNext : null,
              clipBehavior: Clip.hardEdge,
              child: Center(
                child: _formValidated
                    ? CircularProgressIndicator(
                        value: _animationController.value,
                        color: Colors.pink.shade400,
                      )
                    : const Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
