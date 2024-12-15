import 'dart:io';

import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UploadFileData extends StatefulWidget {
  UploadFileData({
    Key? key,
    required this.onChange,
    required this.controller,
    this.controllerType,
  }) : super(key: key);
  final ValueChanged? onChange;
  final TextEditingController controller;
  TextEditingController? controllerType;

  @override
  State<UploadFileData> createState() => _UploadFileDataState();
}

class _UploadFileDataState extends State<UploadFileData> {
  _pickerFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      widget.controller.text = file.path.split('/').last;
      List<File> listFile = [];
      listFile.add(file);
      logger.log("FILE ${result.files.first.extension}");
      widget.controllerType?.text = result.files.first.extension!;
      widget.onChange?.call(listFile);
      final mb = file.lengthSync() / 1024 / 1024;
      if (mb > 10) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Thông Báo'),
                content: Text("Dung lượng ảnh tối đa 10 MB"),
                actions: [
                  TextButton(
                      onPressed: () {
                        context.pop(true);
                        listFile.clear();
                        widget.controller.text = '';
                      },
                      child: const Text('OK'))
                ]);
          },
        );
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: _pickerFile,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: InkWell(
            onTap: _pickerFile,
            child: Container(
              child: Icon(
                Icons.upload,
                color: AppColors.white,
              ),
            )),
        filled: true,
        labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
        contentPadding: const EdgeInsets.only(top: 10, left: 10),
        hintText: "Chọn tệp đính kèm (Tối đa 10MB)",
        hintStyle: TextStyle(fontSize: 16, height: 1.5, color: AppColors.white),
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
