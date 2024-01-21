String formatDate(DateTime date) {
  final dayOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
  final monthNames = [
    '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'
  ];

  return '${monthNames[date.month - 1]} ${date.day}일 ${dayOfWeek[date.weekday - 1]}요일';
}
