import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papas/viewModel/UserViewModel.dart';
import 'package:provider/provider.dart';

import '../common/SharedPreferencesService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late String email;

  @override
  void initState() {
    super.initState();
    email = SharedPreferencesService().getStringValue('email');
    Timer(Duration(seconds: 3), () {
      checkUserLoginStatus();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Splash Screen'),
        ),
      ),
    );
  }

  void checkUserLoginStatus() async {
    if (mounted) {
      UserViewModel userStatus = await Provider.of<UserViewModel>(
          context, listen: false);
      if (userStatus.user != null) {
        print(email);
        context.go('/home', extra: email);
        //context.go('/login');
      } else {
        context.go('/login');
      }
    }
  }
}
