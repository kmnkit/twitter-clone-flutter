import 'package:assign_11/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationNumberField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? nextNode;
  final FocusNode currentNode;
  const VerificationNumberField({
    super.key,
    this.nextNode,
    required this.controller,
    required this.currentNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width - 16 * 5 - Sizes.size32 * 2) / 6,
      child: TextFormField(
        controller: controller,
        autocorrect: false,
        focusNode: currentNode,
        textAlign: TextAlign.center,
        cursorWidth: 2,
        textInputAction: TextInputAction.next,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value == null) return '';
          return value.isEmpty ? '' : null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          counterText: "",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          _fieldFocusChange(
            context,
            currentNode,
            nextNode,
          );
        },
      ),
    );
  }
}

void _fieldFocusChange(BuildContext context, FocusNode current, FocusNode? next) {
  if (next != null) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  } else {
    FocusScope.of(context).unfocus();
  }
}
