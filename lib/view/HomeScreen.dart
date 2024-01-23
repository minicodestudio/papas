import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:papas/model/DiaryModel.dart';
import 'package:provider/provider.dart';

import '../common/Utils.dart';
import '../datasource/DiaryDatasource.dart';
import '../viewModel/HomeViewModel.dart';
import 'CalendarPopup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    // HomeViewModel을 Provider로부터 가져오기
    final HomeViewModel viewModel = Provider.of<HomeViewModel>(context);

    void _handlePopupMenuSelection(BuildContext context, String value, Diary diary) {
      if (value == 'edit') {
        print('edit');
        // Edit logic
        //_editDiary(context, diary);
      } else if (value == 'delete') {
        print('delete');
        // Delete logic
        //_deleteDiary(context, diary);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                _showCalendarPopup(context, viewModel.diaryList);
                //context.push('/calendar', extra: viewModel.diaryList);
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
        body: FutureBuilder(
          future: viewModel.fetchDiaryList('minicodestudio@gmail.com'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return viewModel.diaryList.isNotEmpty
                  ? Center(
                child: ListView.builder(
                  itemCount: viewModel.diaryList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Color(0xFFFFF3DA),
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.subject),
                            title: Text(formatDateString(viewModel.diaryList[index].date), style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),),
                            subtitle: Text(viewModel.diaryList[index].content, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  _handlePopupMenuSelection(context, value, viewModel.diaryList[index]);
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        const SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        const SizedBox(width: 8),
                                        Text('Delete'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
                  : Center(
                child: Text(
                  '우측 하단의 + 버튼으로\n새로운 다이어리를 작성하세요!',
                  style: TextStyle(
                    color: Color(0xFF5B5B5B),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showBottomSheet(context, viewModel);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, HomeViewModel viewModel) {
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
                    onPressed: () async {
                      print('완료...');
                      String content = textEditingController.text;
                      if (content.trim() == "") {
                        Fluttertoast.showToast(msg: "내용을 입력해주세요.", gravity: ToastGravity.BOTTOM);
                        return;
                      }
                      await _saveDiary(context, viewModel, textEditingController.text);
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

  Future<void> _saveDiary(BuildContext context, HomeViewModel viewModel, String content) async {

    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyyMMdd').format(currentDate);

    Diary diary = Diary(content: content, date: formattedDate, user: 'minicodestudio@gmail.com');

    try {
      await viewModel.addDiary(diary);
      viewModel.fetchDiaryList('minicodestudio@gmail.com');

    } catch (e) {
      print("Error saving diary: $e");
      // 실패할 경우에 대한 로직 추가
    }

    // 변경된 데이터를 반영
    //viewModel.notifyListeners();
  }

  void _showCalendarPopup(BuildContext context, List<Diary> diaryList) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CalendarPopup(diaryList: diaryList);
        },
    );
  }
}

