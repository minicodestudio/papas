import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papas/viewModel/UserViewModel.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkUserLoginStatus();
    });
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

  void checkUserLoginStatus() {
    UserViewModel userStatus = Provider.of<UserViewModel>(context, listen: false);
    print(userStatus.user);
    if (userStatus.user != null) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }
}