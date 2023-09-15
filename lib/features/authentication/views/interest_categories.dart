import 'package:assign_11/common/widgets/common_scaffold.dart';
import 'package:assign_11/constants/gaps.dart';
import 'package:assign_11/constants/routes.dart';
import 'package:assign_11/features/authentication/widgets/interest_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    'Grammy Awards',
  ];

  List<String> countries = [
    'Korea',
    'Italy',
    'Spain',
    'Germany',
    'GB',
    'Portugal',
  ];

  List<String> arts = [
    'Painting',
    'Sculpture',
    'Photography',
    'Architecture',
    'Graphic Design',
    'Ceramics',
  ];

  List<String> sports = [
    'Football (or Soccer depending on region)',
    'Basketball',
    'Baseball',
    'Tennis',
    'Yoga',
    'Gym & Fitness',
  ];
  List<String> technologies = [
    'Gadgets',
    'Software Development',
    'Space Exploration',
    'Robotics',
    'Environmental Science',
    'Medicine',
  ];
  List<String> travels = [
    'Backpacking',
    'Urban Exploration',
    'Nature Hiking',
    'Beach Vacations',
    'Adventure Sports'
  ];

  List<String> fashions = [
    'Clothing Trends',
    'Makeup',
    'Skincare',
    'Hair Styling',
    'Accessories',
  ];
  List<String> foods = [
    'Cooking',
    'Baking',
    'Wine Tasting',
    'Craft Beer',
    'Coffee',
  ];
  List<String> businesses = [
    'Investing',
    'Entrepreneurship',
    'Marketing',
    'Real Estate',
    'Cryptocurrencies',
  ];

  List<String> literatures = [
    'Fiction',
    'Poetry',
    'Journalism',
    'Blogging',
    'Non-Fiction',
  ];

  List<String> educations = [
    'Online Courses',
    'Language Learning',
    'History',
    'Philosophy',
    'DIY Projects',
  ];

  List<String> lifeStyles = [
    'Home Decor',
    'Parenting',
    'Gardening',
    'Pets',
    'Crafts',
  ];

  List<String> socialIssues = [
    'Environment',
    'Human Rights',
    'Politics',
    'Community Activism',
    'Charities',
  ];

  List<List<String>> themes = [];

  int _selectedCount = 0;

  void _handleSelectionChanged(bool selected) {
    setState(() {
      selected ? _selectedCount++ : _selectedCount--;
    });
  }

  @override
  void initState() {
    super.initState();
    themes = [
      musics,
      entertainments,
      countries,
      arts,
      sports,
      technologies,
      travels,
      fashions,
      foods,
      businesses,
      literatures,
      educations,
      lifeStyles,
      socialIssues,
    ];
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
              Text("What do you want to see on Threads?", style: headlineStyle),
              Gaps.v16,
              Text(
                "Interests are used to personalize your experience and will be visible on your profile.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black87,
                    ),
              ),
              const Divider(
                height: 32,
              ),
              for (var theme in themes)
                InterestTheme(
                  theme: 'Theme',
                  interests: theme,
                )
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
              onPressed:
                  _selectedCount < 5 ? null : () => context.go(RoutePath.threads),
              child: const Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}
