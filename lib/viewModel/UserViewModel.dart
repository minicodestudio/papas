import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  UserViewModel() {
    initStatus();
  }

  void initStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      //print('user : $user');
      _user = user;
      notifyListeners();
    });
  }
}