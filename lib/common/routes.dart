
import 'package:go_router/go_router.dart';
import 'package:papas/view/HomeScreen.dart';
import 'package:papas/view/LoginScreen.dart';
import 'package:papas/viewModel/UserViewModel.dart';

import '../view/SplashScreen.dart';

class GoRouterClass {
  final UserViewModel userStatus;
  late GoRouter router;

  GoRouterClass(this.userStatus) {
    router = GoRouter(
      initialLocation: "/splash",
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
      ],
      refreshListenable: userStatus,
      redirect: (context, state) {
        if (userStatus.user == null) {
          return "/login";
        }

        return null;
      }
    );
  }
}