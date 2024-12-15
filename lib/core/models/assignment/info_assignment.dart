class InfoAssignment {
  final int id;
  final String title;
  final String description;
  final int lecturer_id;
  final String deadline;
  final String file_url;
  final String class_id;

  InfoAssignment(
    this.id,
    this.title,
    this.description,
    this.lecturer_id,
    this.deadline,
    this.file_url,
    this.class_id,
  );

  factory InfoAssignment.fromJson(Map<String, dynamic> map) {
    return InfoAssignment(
      map['id'] ?? 1,
      map['title'] ?? '',
      map['description'] ?? '',
      map['lecturer_id'] ?? 1,
      map['deadline'] ?? '',
      map['file_url'] ?? '',
      map['class_id'] ?? '',
    );
  }
}
