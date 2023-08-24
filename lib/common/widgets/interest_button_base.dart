import 'package:flutter/material.dart';

abstract class InterestButtonBase extends StatefulWidget {
  final String interest;
  final ValueChanged<bool> onSelectionChanged;

  const InterestButtonBase({
    required this.interest,
    required this.onSelectionChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<InterestButtonBase> createState() => _InterestButtonBaseState();

  @protected
  Widget buildButtonChild(BuildContext context, bool isSelected);
}

class _InterestButtonBaseState extends State<InterestButtonBase> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
      widget.onSelectionChanged(_isSelected);
    });
  }

// Provide a protected getter for _isSelected
  bool get isSelected => _isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.buildButtonChild(context, _isSelected),
    );
  }
}
