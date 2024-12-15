class InfoClassStudent {
  final String class_id;
  final String class_name;
  final String lecturer_id;
  final String lecturer_name;
  final String max_student_amount;
  final String class_type;
  final String start_date;
  final String end_date;
  final String status;

  InfoClassStudent(
    this.class_id,
    this.class_name,
    this.lecturer_id,
    this.lecturer_name,
    this.max_student_amount,
    this.class_type,
    this.start_date,
    this.end_date,
    this.status,
  );

  factory InfoClassStudent.fromJson(Map<String, dynamic> map) {
    return InfoClassStudent(
      map['class_id'] ?? '',
      map['class_name'] ?? '',
      map['lecturer_id'] ?? '',
      map['lecturer_name'] ?? '',
      map['max_student_amount'] ?? '',
      map['class_type'] ?? '',
      map['start_date'] ?? '',
      map['end_date'] ?? '',
      map['status'] ?? '',
    );
  }
}
