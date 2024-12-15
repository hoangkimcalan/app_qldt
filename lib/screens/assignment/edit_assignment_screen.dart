import 'dart:io';

import 'package:app_qldt_hust/core/blocs/assignment/cubit/assignment_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/date_picker_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/widget_custom.dart';
import 'package:app_qldt_hust/core/models/assignment/info_assignment.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:app_qldt_hust/screens/lecturer/widgets/textformfield_lecture.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EditAssignmentScreen extends StatefulWidget {
  final InfoAssignment infoAssignment;
  const EditAssignmentScreen({super.key, required this.infoAssignment});

  @override
  State<EditAssignmentScreen> createState() => _EditAssignmentScreenState();
  static String get routerConfig => '/edit_assignment';
}

class _EditAssignmentScreenState extends State<EditAssignmentScreen> {
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

  @override
  void initState() {
    titleController.text = widget.infoAssignment.title;
    descriptionController.text = widget.infoAssignment.description;
    deadlineController.text = widget.infoAssignment.deadline;
    super.initState();
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

  Future<void> onSubmit() async {
    print(titleController.text);
    print(descriptionController.text);
    await assignmentCubit.editAssignment(
      widget.infoAssignment.id.toString(),
      titleController.text,
      descriptionController.text,
      deadlineController.text,
      fileUpLoad,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redDelete,
      appBar: AppBar(
        backgroundColor: AppColors.redDelete,
        centerTitle: true,
        title: InkWell(
          child: Text(
            "Chỉnh sửa bài tập",
            style: TextStyles.text18w6white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener(
            bloc: assignmentCubit,
            listener: (context, state) {
              if (state is AssignmentEditLoading) {
                CustomLoading(context);
              } else if (state is AssignmentEditLoaded) {
                showToastSuccess(message: "Chỉnh sửa bài tập thành công");
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  enabled: false,
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
