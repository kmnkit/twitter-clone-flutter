import 'package:assign_11/common/widgets/common_scaffold.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/features/widgets/interest_button.dart';
import 'package:assign_11/screens/sign_up/interest_list.dart';
import 'package:flutter/material.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({
    super.key,
  });

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  int _selectedCount = 0;

  void _onScroll() {
    if (_scrollController.offset < 100) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  List<String> interests = [
    'Fashion & Beauty',
    'Outdoors',
    'Arts & Culture',
    'Animation & Comics',
    'Business & Finance',
    'Food',
    'Travel',
    'Entertainment',
    'Music',
    'Gaming',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: _showTitle ? 1 : 0,
          child: const Text(
            'Choose your interests',
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What do you want to see on Twitter?",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              Gaps.v16,
              Text(
                "Select at least 3 interests to personalize your Twitter experiences. They will be visible on your profile.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black87,
                    ),
              ),
              Gaps.v16,
              const Divider(),
              Gaps.v32,
              Wrap(
                runSpacing: 16,
                spacing: 16,
                children: [
                  for (var interest in interests)
                    InterestButton(
                      interest: interest,
                      onSelectionChanged: (selected) {
                        if (selected) {
                          _selectedCount++;
                        } else {
                          _selectedCount--;
                        }
                        setState(() {});
                      },
                    )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomBar: BottomAppBar(
        elevation: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedCount < 3 ? '' : 'Great Work! ❤️'),
            ElevatedButton(
                onPressed: _selectedCount < 3
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InterestListScreen(),
                          ),
                        );
                      },
                child: const Text('Next'))
          ],
        ),
      ),
    );
  }
}
