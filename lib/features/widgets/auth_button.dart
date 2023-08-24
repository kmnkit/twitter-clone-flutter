import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final void Function(BuildContext) func;
  final Widget? icon;

  const AuthButton({
    super.key,
    this.icon,
    required this.func,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func(context),
      child: FractionallySizedBox(
        // 부모 크기에 비례해서 크기 정하게 해주는 위젯
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(
            Sizes.size14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Sizes.size36,
            ),
            border: Border.all(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: icon,
              ),
              Gaps.h16,
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).typography.englishLike.labelMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
