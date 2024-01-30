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
    _diaryList = diaryData.map((data) => Diary.fromJson(data, documentId: data['documentId'])).toList();
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

  Future<void> deleteDiary(String documentId) async {
    try {
      await _dataSource.deleteDiary(documentId);
      notifyListeners();
    } catch (e) {
      print("Error deleting diary: $e");
    }
  }

  Future<void> updateDiary(String documentId, String newContent) async {
    try {
      await _dataSource.updateDiary(documentId, newContent);
      notifyListeners();
    } catch (e) {
      print("Error updating diary: $e");
    }
  }
}