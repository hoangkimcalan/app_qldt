class InfoUser {
  final String id;
  final String email;
  final String ho;
  final String ten;
  final String name;
  final String token;
  final String role;
  final String status;
  final String avatar;
  final List<dynamic> class_list;

  InfoUser(
      {required this.id,
      required this.email,
      required this.ho,
      required this.ten,
      required this.name,
      required this.token,
      required this.role,
      required this.status,
      required this.avatar,
      required this.class_list});

  factory InfoUser.fromJson(Map<String, dynamic> json) => InfoUser(
      id: (json["id"] ?? -1).toString(),
      email: (json["email"] ?? "").toString(),
      ho: (json["ho"] ?? "").toString(),
      ten: (json["ten"] ?? "").toString(),
      name: (json["name"] ?? "").toString(),
      token: (json["token"] ?? "").toString(),
      role: (json["role"] ?? "").toString(),
      status: (json["status"] ?? "").toString(),
      avatar: (json["avatar"] ?? "").toString(),
      class_list: (json["class_list"] ?? []).map((e) => e as Object).toList());
}
