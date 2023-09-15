import 'package:flutter/material.dart';

class BottomSheetListTile extends StatelessWidget {
  final String text;
  final bool isTop;
  final Color? color;
  final Function onTap;
  const BottomSheetListTile({
    super.key,
    required this.text,
    this.isTop = true,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: isTop
            ? const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )
            : const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
      ),
      tileColor: Colors.grey.shade200,
    );
  }
}
