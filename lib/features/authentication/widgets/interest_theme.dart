import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/authentication/widgets/interest_button.dart';
import 'package:flutter/material.dart';

class InterestTheme extends StatefulWidget {
  final String theme;
  final List<String> interests;
  const InterestTheme({
    super.key,
    required this.theme,
    required this.interests,
  });

  @override
  State<InterestTheme> createState() => _InterestThemeState();
}

class _InterestThemeState extends State<InterestTheme> {
  Widget _buildInterestGridView(List<String> interests) {
    return SizedBox(
      height: 160,
      child: GridView.builder(
        itemCount: interests.length,
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50,
          crossAxisSpacing: Sizes.size8,
          mainAxisSpacing: Sizes.size8,
          childAspectRatio: 1 / 3,
        ),
        itemBuilder: (context, index) => InterestButton(
          interest: interests[index],
          onSelectionChanged: (value) {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w800,
        );
    return Wrap(
      children: [
        Text(widget.theme, style: headlineStyle),
        Gaps.v16,
        _buildInterestGridView(widget.interests),
        const Divider(
          height: 32,
        )
      ],
    );
  }
}
