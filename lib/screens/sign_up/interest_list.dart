import 'package:assign_11/common/widgets/common_scaffold.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/sizes.dart';
import 'package:assign_11/features/widgets/detail_interest_button.dart';
import 'package:assign_11/screens/congrats.dart';
import 'package:flutter/material.dart';

class InterestListScreen extends StatefulWidget {
  const InterestListScreen({super.key});

  @override
  State<InterestListScreen> createState() => _InterestListScreenState();
}

class _InterestListScreenState extends State<InterestListScreen> {
  final ScrollController _scrollController = ScrollController();

  List<String> musics = [
    'Rap',
    'R&B & Soul',
    'Grammy Awards',
    'Pop',
    'K-pop',
    'Music Industry',
    'EDM',
    'Music News',
    'Hip hop',
    'Reggae',
    'Rock',
  ];

  List<String> entertainments = [
    'Anime',
    'Movies & TV',
    'Harry Potter',
    'Marvel Universe',
    'Movie News',
    'One Piece',
    'Movies',
    'Grammy Awards',
  ];

  List<String> travels = [
    'Korea',
    'Italy',
    'Spain',
    'Germany',
    'GB',
    'Portugal',
  ];

  int _selectedCount = 0;

  void _handleSelectionChanged(bool selected) {
    setState(() {
      selected ? _selectedCount++ : _selectedCount--;
    });
  }

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
        itemBuilder: (context, index) => DetailInterestButton(
          interest: interests[index],
          onSelectionChanged: _handleSelectionChanged,
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

    return CommonScaffold(
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("What do you want to see on Twitter?", style: headlineStyle),
              Gaps.v16,
              Text(
                "Interests are used to personalize your experience and will be visible on your profile.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black87,
                    ),
              ),
              Gaps.v16,
              const Divider(),
              Gaps.v32,
              Text('Music', style: headlineStyle),
              Gaps.v16,
              _buildInterestGridView(musics),
              Gaps.v16,
              const Divider(),
              Gaps.v32,
              Text('Entertainment', style: headlineStyle),
              Gaps.v16,
              _buildInterestGridView(entertainments),
              Gaps.v16,
              const Divider(),
            ],
          ),
        ),
      ),
      bottomBar: BottomAppBar(
        elevation: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedCount < 5 ? '' : 'Great Work! ❤️'),
            ElevatedButton(
                onPressed: _selectedCount < 5
                    ? null
                    : () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
                child: const Text('Next'))
          ],
        ),
      ),
    );
  }
}
