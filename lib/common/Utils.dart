String formatDate(DateTime date) {
  final dayOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
  final monthNames = [
    '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'
  ];

  return '${monthNames[date.month - 1]} ${date.day}일 ${dayOfWeek[date.weekday - 1]}요일';
}

// 20240121 --> 2024년01월21일 일요일
String formatDateString(String dateString) {
  DateTime date = DateTime.parse(dateString);

  // 요일을 표시하기 위한 요일 문자열 배열
  final List<String> daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

  // 'YYYY년MM월DD일' 형태로 문자열 생성
  String formattedString =
      '${date.year}년${date.month.toString().padLeft(2, '0')}월${date.day.toString().padLeft(2, '0')}일';

  // 해당 날짜의 요일을 추가
  formattedString += ' ${daysOfWeek[date.weekday - 1]}요일';

  return formattedString;
}