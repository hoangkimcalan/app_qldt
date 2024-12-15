import 'dart:io';

import 'package:app_qldt_hust/core/blocs/assignment/cubit/assignment_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/date_picker_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/widget_custom.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:app_qldt_hust/screens/lecturer/widgets/textformfield_lecture.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CreateAssignmentScreen extends StatefulWidget {
  final String class_id;
  const CreateAssignmentScreen({super.key, required this.class_id});

  @override
  State<CreateAssignmentScreen> createState() => _CreateAssignmentScreenState();
  static String get routerConfig => '/create_assignment';
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController controllerNameFile = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  late File fileUpLoad;

  late AssignmentCubit assignmentCubit = AssignmentCubit();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    controllerNameFile.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    await assignmentCubit.createAssignment(
      widget.class_id,
      titleController.text,
      descriptionController.text,
      deadlineController.text,
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

  Future<void> _selectDateStart(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        final formattedDate =
            DateFormat('yyyy-MM-ddTHH:mm:ss').format(pickedDate);
        deadlineController.text = formattedDate;
      });
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
          child: Text("Thêm bài tập mới", style: TextStyles.text18w6white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener(
            bloc: assignmentCubit,
            listener: (context, state) {
              if (state is AssignmentUploadLoading) {
                CustomLoading(context);
              } else if (state is AssignmentUploadLoaded) {
                showToastSuccess(message: "Tải bài tập thành công");
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
                  decoration: InputDecorationLecture("Tên bài tập"),
                ),
                SizedBox(height: 24),
                TextFormField(
                  maxLines: 10,
                  style: TextStyle(color: Colors.white),
                  controller: descriptionController,
                  decoration: InputDecorationLecture("Mô tả"),
                ),
                SizedBox(height: 24),
                CommonDatePickerField(
                  labelText: 'Hạn nộp',
                  controller: deadlineController,
                  onTap: () {
                    _selectDateStart(context);
                  },
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: controllerNameFile,
                  onTap: _pickerFile,
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
