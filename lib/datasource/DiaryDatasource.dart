import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/DiaryModel.dart';

class DiaryDataSource {
  DiaryDataSource();

  Future<List<Map<String, dynamic>>> getDiaryList(String userEmail) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('diary')
          .where('user', isEqualTo: userEmail)
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() ?? {};
        data['documentId'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching diary list: $e');
      return [];
    }
  }

  Future<void> addDiary(Diary newDiary) async {
    try {
      // Firestore에 다이어리 추가
      await FirebaseFirestore.instance.collection('diary').add(newDiary.toMap());
    } catch (e) {
      // 에러 발생 시 예외 던지기
      throw Exception("다이어리 추가에 실패했습니다.");
    }
  }

  Future<void> deleteDiary(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('diary').doc(documentId).delete();
    } catch (e) {
      throw Exception("다이어리 삭제에 실패했습니다.");
    }
  }

  Future<void> updateDiary(String documentId, String newContent) async {
    try {
      await FirebaseFirestore.instance.collection('diary').doc(documentId).update({
        'content': newContent,
      });
    } catch (e) {
      throw Exception("다이어리 업데이트에 실패했습니다.");
    }
  }
  
}