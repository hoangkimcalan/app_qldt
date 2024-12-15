class InfoMaterial {
  final String id;
  final String class_id;
  final String material_name;
  final String description;
  final String material_link;
  final String material_type;

  InfoMaterial(
    this.id,
    this.class_id,
    this.material_name,
    this.description,
    this.material_link,
    this.material_type,
  );

  factory InfoMaterial.fromJson(Map<String, dynamic> map) {
    return InfoMaterial(
      map['id'] ?? '',
      map['class_id'] ?? '',
      map['material_name'] ?? '',
      map['description'] ?? '',
      map['material_link'] ?? '',
      map['material_type'] ?? '',
    );
  }
}
