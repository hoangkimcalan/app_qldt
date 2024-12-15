import 'dart:io';

import 'package:app_qldt_hust/core/blocs/material/cubit/material_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/widget_custom.dart';
import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:app_qldt_hust/screens/lecturer/widgets/textformfield_lecture.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UploadMaterialScreen extends StatefulWidget {
  final String class_id;
  const UploadMaterialScreen({super.key, required this.class_id});

  @override
  State<UploadMaterialScreen> createState() => _UploadMaterialScreenState();
  static String get routerConfig => '/upload_material';
}

class _UploadMaterialScreenState extends State<UploadMaterialScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController controllerNameFile = TextEditingController();
  late File fileUpLoad;

  late MaterialCubit materialCubit = MaterialCubit();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    typeController.dispose();
    controllerNameFile.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    await materialCubit.uploadMaterial(
      widget.class_id,
      titleController.text,
      descriptionController.text,
      typeController.text,
      fileUpLoad,
    );
  }

  _pickerFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      controllerNameFile.text = file.path.split('/').last;
      List<File> listFile = [];
      fileUpLoad = file;
      listFile.add(file);
      logger.log("FILE ${result.files.first.extension}");
      typeController.text = result.files.first.extension!;
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
    return Scaffold(
      backgroundColor: AppColors.redDelete,
      appBar: AppBar(
        backgroundColor: AppColors.redDelete,
        centerTitle: true,
        title: InkWell(
          child: Text("Tải lên tài liệu mới", style: TextStyles.text18w6white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener(
            bloc: materialCubit,
            listener: (context, state) {
              if (state is MaterialUploadLoading) {
                CustomLoading(context);
              } else if (state is MaterialUploadLoaded) {
                showToastSuccess(message: "Tải tài liệu thành công");
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: titleController,
                  decoration: InputDecorationLecture("Tên tài liệu"),
                ),
                SizedBox(height: 24),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: descriptionController,
                  decoration: InputDecorationLecture("Mô tả"),
                ),
                SizedBox(height: 24),
                TextFormField(
                  onTap: _pickerFile,
                  controller: controllerNameFile,
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
                    hintStyle: TextStyle(
                        fontSize: 16, height: 1.5, color: AppColors.white),
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                buttonColors(context, "Tải lên", 20, () async {
                  onSubmit();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
