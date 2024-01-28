import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.0,
            title: Text(
              '앱 정보',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: false,
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('PAPAS 아이콘 넣기'),
                      Text('${_packageInfo.appName}', style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                      ),),
                      Text('v${_packageInfo.version}', style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),),
                    ],
                  ),
                ),
                Column(
                  children: [
                    // Container(
                    //     padding: EdgeInsets.all(32.0),
                    //     child: Divider(thickness: 1, height: 1, color: Colors.grey[300]),
                    // ),
                    Image.asset('assets/images/mcs_ci.png', width: 125.0,),
                    SizedBox(height: 8.0,),
                    Text('Copyrightⓒ2024 MiniCodeStudio All rights reserved.', style: TextStyle(fontSize: 10.0, ),),
                  ],
                ),
                SizedBox(height: 64.0,)
              ],
            ),
          ),
        )
    );
  }
}
