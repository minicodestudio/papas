import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papas/firebase_options.dart';
import 'package:papas/common/Routes.dart';
import 'package:papas/viewModel/UserViewModel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserViewModel userStatus = UserViewModel();

  @override
  Widget build(BuildContext context) {
    GoRouterClass router = GoRouterClass(userStatus);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserViewModel>.value(
          value: userStatus,
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router.router,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "NotoSansKR",
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF6C5C39)),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFF6E1B8),
            foregroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
