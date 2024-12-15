import 'package:app_qldt_hust/screens/lecturer/widgets/textformfield_lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonDatePickerField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String dateFormat;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CommonDatePickerField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.dateFormat = "yyyy/MM/dd",
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: TextStyle(color: Colors.white),
      readOnly: true, // Chỉ cho phép chọn ngày, không cho nhập tay
      onTap: onTap,
      decoration: InputDecorationLecture(labelText),
    );
  }
}
