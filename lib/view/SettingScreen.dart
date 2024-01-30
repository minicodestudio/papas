import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../common/SharedPreferencesService.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String displayName;
  late String email;
  late String photoUrl;

  @override
  void initState() {
    super.initState();
    displayName = SharedPreferencesService().getStringValue('displayName');
    email = SharedPreferencesService().getStringValue('email');
    photoUrl = SharedPreferencesService().getStringValue('photoUrl');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.0,
            title: Text(
              '설정',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: false,
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFF1F1F1),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(photoUrl),
                      ),
                    ),
                    Text('$displayName', style : TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
                    Text('$email', style : TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),),
                  ],
                ),
                SizedBox(height: 16.0,),
                Divider(thickness: 1, height: 1, color: Colors.grey[300]),
                SizedBox(height: 12.0,),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('계정 설정', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500,),),
                        // SizedBox(height: 12.0),
                        GestureDetector(onTap: () { Fluttertoast.showToast(msg: "중비중인 기능 입니다.", gravity: ToastGravity.BOTTOM); }, child: Text('배우자 등록', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500,),)),
                        SizedBox(height: 12.0),
                        GestureDetector(onTap: () { Fluttertoast.showToast(msg: "중비중인 기능 입니다.", gravity: ToastGravity.BOTTOM); }, child: Text('공지사항', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500,),)),
                        SizedBox(height: 12.0),
                        GestureDetector(onTap: () { Fluttertoast.showToast(msg: "중비중인 기능 입니다.", gravity: ToastGravity.BOTTOM); }, child: Text('자주하는질문', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500,),)),
                        SizedBox(height: 12.0),
                        GestureDetector(onTap: () { Fluttertoast.showToast(msg: "중비중인 기능 입니다.", gravity: ToastGravity.BOTTOM); }, child: Text('건의사항', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500,),)),
                        SizedBox(height: 12.0),
                        GestureDetector(
                          onTap: () {
                            context.push('/appInfo');
                          },
                          child: Text('앱 정보', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500,),)
                        ),
                      ],
                    )
                ),
                GestureDetector(
                    onTap: () async {
                      SharedPreferencesService().setStringValue('displayName', "");
                      SharedPreferencesService().setStringValue('email', "");
                      SharedPreferencesService().setStringValue('photoUrl', "");

                      await _auth.signOut();
                      context.go('/login');
                    },
                    child: Text('로그 아웃', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, decoration: TextDecoration.underline),)
                ),
              ],
            ),
          ),
        )
    );
  }
}
