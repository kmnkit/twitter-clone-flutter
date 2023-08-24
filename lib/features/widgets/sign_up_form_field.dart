import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  const SignUpFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      onChanged: validator,
      scrollPadding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: controller.text.isNotEmpty
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
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      onSaved: (newValue) {
        if (newValue != null) {
          return;
        }
      },
      validator: validator,
    );
  }
}
