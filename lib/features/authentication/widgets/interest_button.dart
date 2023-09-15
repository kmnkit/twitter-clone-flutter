import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InterestButton extends StatefulWidget {
  final String interest;
  final ValueChanged<bool> onSelectionChanged;
  const InterestButton({
    super.key,
    required this.interest,
    required this.onSelectionChanged,
  });

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  _InterestButtonState();

  bool _isSelected = false;

  @override
  Widget build(BuildContext context) => ActionChip(
        avatar: FaIcon(_isSelected
            ? FontAwesomeIcons.solidCircleCheck
            : FontAwesomeIcons.circleCheck),
        clipBehavior: Clip.hardEdge,
        label: Text(
          widget.interest,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: () {
          setState(() {
            _isSelected = !_isSelected;
            widget.onSelectionChanged(_isSelected);
          });
        },
      );
}
