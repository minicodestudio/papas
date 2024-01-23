import 'package:flutter/material.dart';

import '../common/SharedPreferencesService.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late String displayName;
  late String email;
  late String photoUrl;

  @override
  void initState() {
    super.initState();
    displayName = SharedPreferencesService().getStringValue('name');
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
                  children: [
                    Text('$displayName'),
                    Text('$email'),
                  ],
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('계정 설정', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500,),),
                        SizedBox(height: 12.0),
                        Text('앱 정보', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500,),),
                      ],
                    )
                ),
                Text('로그 아웃', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, decoration: TextDecoration.underline),),
              ],
            ),
          ),
        )
    );
  }
}
