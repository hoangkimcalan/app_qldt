class InfoClass {
  final String class_id;
  final String class_name;
  final String attached_code;
  final String lecturer_account_id;
  final String lecturer_name;
  final String student_count;
  final String class_type;
  final String start_date;
  final String end_date;
  final String status;
  final List<dynamic> student_accounts;

  InfoClass(
    this.class_id,
    this.class_name,
    this.attached_code,
    this.lecturer_account_id,
    this.lecturer_name,
    this.student_count,
    this.class_type,
    this.start_date,
    this.end_date,
    this.status,
    this.student_accounts,
  );

  factory InfoClass.fromJson(Map<String, dynamic> map) {
    return InfoClass(
        map['class_id'] ?? '',
        map['class_name'] ?? '',
        map['attached_code'] ?? '',
        map['lecturer_account_id'] ?? '',
        map['lecturer_name'] ?? '',
        map['student_count'] ?? '',
        map['class_type'] ?? '',
        map['start_date'] ?? '',
        map['end_date'] ?? '',
        map['status'] ?? '',
        map['student_accounts'] ?? []);
  }
}

class StudentAccount {
  final String account_id;
  final String last_name;
  final String first_name;
  final String email;
  final String student_id;

  StudentAccount({
    required this.account_id,
    required this.last_name,
    required this.first_name,
    required this.email,
    required this.student_id,
  });

  factory StudentAccount.fromJson(Map<String, dynamic> map) {
    return StudentAccount(
      account_id: map['account_id'] ?? '',
      last_name: map['last_name'] ?? '',
      first_name: map['first_name'] ?? '',
      email: map['email'] ?? '',
      student_id: map['student_id'] ?? '',
    );
  }
}
