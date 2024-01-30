import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void initState() {
    super.initState();
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
        backgroundColor: Color(0xFFF4E5D1),
        body: Center(
          child: Image.asset('assets/images/papas_icon.png'),
        ),
      ),
    );
  }

  void checkUserLoginStatus() async {
    if (mounted) {
      UserViewModel userStatus = await Provider.of<UserViewModel>(context, listen: false);
      User? user = userStatus.user;

      SharedPreferencesService().setStringValue('displayName', user!.displayName.toString());
      SharedPreferencesService().setStringValue('email', user!.email.toString());
      SharedPreferencesService().setStringValue('photoUrl', user!.photoURL.toString());
      if (userStatus.user != null) {
        context.go('/home', extra: user!.email.toString());
        //context.go('/login');
      } else {
        context.go('/login');
      }
    }
  }
}
