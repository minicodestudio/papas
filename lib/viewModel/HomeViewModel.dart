import 'package:flutter/material.dart';
import 'package:papas/model/DiaryModel.dart';
import '../common/utils.dart';
import 'package:provider/provider.dart';

import '../datasource/DiaryDatasource.dart';

class HomeViewModel extends ChangeNotifier {
  final DiaryDataSource _dataSource;

  HomeViewModel(this._dataSource);

  List<Diary> _diaryList = [];

  List<Diary> get diaryList => _diaryList;

  Future<void> fetchDiaryList(String userEmail) async {
    List<Map<String, dynamic>> diaryData = await _dataSource.getDiaryList(userEmail);
    _diaryList = diaryData.map((data) => Diary.fromJson(data)).toList();
    //notifyListeners();
  }

  Future<void> addDiary(Diary newDiary) async {
    try {
      await _dataSource.addDiary(newDiary);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}