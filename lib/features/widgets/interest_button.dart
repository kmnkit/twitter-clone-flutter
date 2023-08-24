import 'package:assign_11/common/widgets/interest_button_base.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InterestButton extends InterestButtonBase {
  const InterestButton({
    super.key,
    required super.interest,
    required super.onSelectionChanged,
  });

  @override
  Widget buildButtonChild(BuildContext context, bool isSelected) {
    return AnimatedContainer(
      width: (MediaQuery.sizeOf(context).width - Sizes.size32 * 2 - 16) / 2,
      height: Sizes.size60,
      duration: const Duration(
        milliseconds: 150,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size8,
        horizontal: Sizes.size8,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor
            : isSelected
                ? Colors.grey.shade700
                : Colors.white,
        borderRadius: BorderRadius.circular(
          Sizes.size16,
        ),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size5,
            color: Colors.black.withOpacity(
              0.05,
            ),
            spreadRadius: Sizes.size5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                interest,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: FaIcon(
              FontAwesomeIcons.solidCircleCheck,
              color: Colors.white,
              size: Sizes.size16,
            ),
          ),
        ],
      ),
    );
  }
}
