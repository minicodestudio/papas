import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/Utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> diaryList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          title: Text(
            '파파스',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () {
                print('calendar_month clicked...');
              },
              child: Container(
                margin: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.calendar_month, size: 32.0,),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('settings clicked...');
                context.push('/settings');
              },
              child: Container(
                margin: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.settings, size: 32.0,),
              ),
            ),
          ],
        ),
        body: diaryList.length > 0? DiaryContent(diaryList: diaryList) :
        Center(
          child: Text('우측 하단의 + 버튼으로\n새로운 다이어리를 작성하세요!',
          style: TextStyle(
            color: Color(0xFF5B5B5B),
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showBottomSheet(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 화면 높이에 맞게 스크롤 가능하게 설정
      builder: (BuildContext context) {
        // 포커스를 설정할 텍스트 컨트롤러 생성
        TextEditingController textEditingController = TextEditingController();

        DateTime currentDate = DateTime.now();
        String formattedDate = formatDate(currentDate);

        return Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.85, // 화면 높이의 85%로 설정
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // 완료 버튼 눌렸을 때의 로직 추가
                      print('완료...');
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '완료',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: '다이어리를 작성하세요...',
                  border: InputBorder.none,
                ),
                maxLines: 20,
                onSubmitted: (String value) {
                  // 저장 로직 추가
                  Navigator.of(context).pop(); // Bottom sheet 닫기
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     // 저장 로직 추가
              //     Navigator.of(context).pop(); // Bottom sheet 닫기
              //   },
              //   child: Text('Save Diary'),
              // ),
            ],
          ),
        );
      },
    );
  }
}

class DiaryContent extends StatelessWidget {
  final List<String> diaryList;

  const DiaryContent({Key? key, required this.diaryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: diaryList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(diaryList[index]),
            ),
          );
        },
      ),
    );
  }
}
