import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../common/SharedPreferencesService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? displayName;
  String? email;
  String? photoUrl;

  Future<User?> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // 사용자가 로그인을 취소했거나 오류가 발생했습니다.
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      if (authResult != null) {
        User? user = await authResult.user;
        displayName = user?.displayName;
        email = user?.email;
        photoUrl = user?.photoURL;

        SharedPreferencesService().setStringValue('displayName', displayName.toString());
        SharedPreferencesService().setStringValue('email', email.toString());
        SharedPreferencesService().setStringValue('photoUrl', photoUrl.toString());
      }

      final User? user = authResult.user;

      return user;
    } catch (error) {
      print("Google Sign In Error: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFF6E1B8),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('파파스\n다이어리', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700,),),
                SizedBox(height: 16.0,),
                Text('사랑하는 아이에게\n소중한 이야기를 남겨주세요!', style: TextStyle(color: Color(0xFF5B5B5B), fontSize: 24.0, fontWeight: FontWeight.w500,),),
                SizedBox(height: 32.0,),
                Divider(thickness: 1, color: Colors.white,),
                SizedBox(height: 32.0,),
                GestureDetector(
                  onTap: () async {
                    User? user = await _handleGoogleSignIn();
                    if (user != null) {
                      // Google 로그인 성공, 원하는 동작 수행
                      print("Google 로그인 성공: ${user.displayName}");
                      context.go('/home', extra: user.email);
                    } else {
                      // Google 로그인 실패
                      print("Google 로그인 실패");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6E1B8),
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Color(0xFFF6E1B8),
                        width: 1,
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google.png', width: 28.0,),
                        SizedBox(width: 8.0,),
                        Text('Google 계정으로 로그인', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600,),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
