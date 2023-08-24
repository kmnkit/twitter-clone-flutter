import 'package:assign_11/common/widgets/common_scaffold.dart';
import 'package:flutter/material.dart';

class SignUpCompleteScreen extends StatelessWidget {
  const SignUpCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Text(
        'Welcome!',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
