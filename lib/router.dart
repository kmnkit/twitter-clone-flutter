import 'package:assign_11/common/widgets/main_nav/screens/main_nav.dart';
import 'package:assign_11/constants/routes.dart';
import 'package:assign_11/features/authentication/repos/authentication_repo.dart';
import 'package:assign_11/features/authentication/views/sign_in.dart';
import 'package:assign_11/features/authentication/views/sign_up.dart';
import 'package:assign_11/features/settings/views/mentions.dart';
import 'package:assign_11/features/settings/views/privacy.dart';
import 'package:assign_11/features/settings/views/settings.dart';
import 'package:assign_11/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

final _key = GlobalKey<NavigatorState>();
// context.go
//
final routerProvider = Provider<GoRouter>((ref) {
  ref.watch(authState);
  return GoRouter(
    navigatorKey: _key,
    initialLocation: RoutePath.signIn,
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      switch (state.matchedLocation) {
        case RoutePath.threads ||
              RoutePath.search ||
              RoutePath.post ||
              RoutePath.activity ||
              RoutePath.profile ||
              RoutePath.settings ||
              RoutePath.privacySetting:
          if (isLoggedIn) {
            return state.matchedLocation;
          } else {
            return RoutePath.signIn;
          }
        case RoutePath.home:
          if (isLoggedIn) {
            return RoutePath.threads;
          }
          return state.matchedLocation;
        case RoutePath.signIn:
          if (isLoggedIn) {
            return RoutePath.threads;
          }
          return state.matchedLocation;
        default:
          return null;
      }
    },
    routes: [
      GoRoute(
        path: RoutePath.home,
        name: RouteName.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutePath.signUp,
        name: RouteName.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: RoutePath.signIn,
        name: RouteName.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RoutePath.settings,
        name: RouteName.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: RoutePath.privacySetting,
        name: RouteName.privacySetting,
        builder: (context, state) => const PrivacyScreen(),
      ),
      GoRoute(
        path: RoutePath.allowMentionsSetting,
        name: RouteName.allowMentionsSetting,
        builder: (context, state) => const MentionsScreen(),
      ),
      GoRoute(
          path: "/:tab(threads|search|post|activity|profile)",
          name: RouteName.mainNav,
          builder: (context, state) {
            final tab = state.pathParameters['tab']!;
            return MainNavigationScreen(tab: tab);
          }),
    ],
  );
});
