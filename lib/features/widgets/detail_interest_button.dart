import 'package:assign_11/common/widgets/interest_button_base.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:flutter/material.dart';

// class DetailInterestButton extends StatefulWidget {
//   final String interest;
//   final ValueChanged<bool> onSelectionChanged;

//   const DetailInterestButton({
//     super.key,
//     required this.interest,
//     required this.onSelectionChanged,
//   });

//   @override
//   State<DetailInterestButton> createState() => _DetailInterestButtonState();
// }

// class _DetailInterestButtonState extends State<DetailInterestButton> {
//   bool _isSelected = false;
//   void _onTap() {
//     setState(() {
//       _isSelected = !_isSelected;
//       widget.onSelectionChanged(_isSelected);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _onTap,
//       child: AnimatedContainer(
//         duration: const Duration(
//           milliseconds: 150,
//         ),
//         padding: const EdgeInsets.symmetric(
//           vertical: Sizes.size8,
//           horizontal: Sizes.size8,
//         ),
//         clipBehavior: Clip.hardEdge,
//         height: 32,
//         decoration: BoxDecoration(
//           color: _isSelected ? Colors.purple.shade400 : Colors.grey.shade400,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(
//           widget.interest,
//           textAlign: TextAlign.center,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: _isSelected ? Colors.white : Colors.black87,
//           ),
//         ),
//       ),
//     );
//   }
// }

class DetailInterestButton extends InterestButtonBase {
  const DetailInterestButton({
    super.key,
    required super.interest,
    required super.onSelectionChanged,
  });

  @override
  Widget buildButtonChild(BuildContext context, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 150,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size8,
        horizontal: Sizes.size8,
      ),
      clipBehavior: Clip.hardEdge,
      height: 32,
      decoration: BoxDecoration(
        color: isSelected ? Colors.pink.shade200 : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        interest,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
