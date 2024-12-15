import 'package:app_qldt_hust/core/blocs/student/class/cubit/class_student_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/repos/student/class/class_repo.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:app_qldt_hust/screens/lecturer/widgets/textformfield_lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterClassScreen extends StatefulWidget {
  const RegisterClassScreen({super.key});

  @override
  State<RegisterClassScreen> createState() => _RegisterClassScreenState();
  static String get routerConfig => '/register_class';
}

class _RegisterClassScreenState extends State<RegisterClassScreen> {
  final List<Map<String, String>> classData = [
    {
      "Mã lớp": "L001",
      "Mã lớp kèm": "LK001",
      "Tên lớp": "Toán Cao Cấp",
      "Giảng viên": "Thầy A",
      "Trạng thái": "Đang học",
      "Ngày bắt đầu": "01/09/2023",
      "Ngày kết thúc": "01/12/2023"
    },
  ];

  late ClassStudentCubit _classStudentCubit;
  late ClassRepository _classRepository;
  final TextEditingController _classIdController = TextEditingController();
  List<String> classCheckBox = [];

  @override
  void initState() {
    super.initState();
    _classStudentCubit = ClassStudentCubit();
    _classStudentCubit.getListClass();
  }

  @override
  void dispose() {
    _classIdController.dispose();
    super.dispose();
  }

  void toggleClassCheck(String class_id) {
    if (classCheckBox.contains(class_id)) {
      classCheckBox.remove(class_id);
    } else {
      classCheckBox.add(class_id);
    }
    setState(() {});
  }

  Future<void> registerClass(List<String> class_ids) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redDelete,
      appBar: AppBar(
        backgroundColor: AppColors.redDelete,
        centerTitle: true,
        title: InkWell(
          child: Text("Đăng ký lớp", style: TextStyles.text18w6white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _classIdController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecorationLecture("Mã lớp học"),
                  ),
                ),
                SizedBox(width: 8),
                buttonColors(context, "Đăng ký", 20, () async {
                  _classStudentCubit.getBasicClassInfo(
                    class_id: _classIdController.text,
                  );
                })
              ],
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildTitleBox(""),
                      _buildTitleBox("Mã lớp"),
                      _buildTitleBox("Mã lớp kèm"),
                      _buildTitleBox("Tên lớp"),
                      _buildTitleBox("Giảng viên"),
                      _buildTitleBox("Trạng thái"),
                      _buildTitleBox("Ngày bắt đầu"),
                      _buildTitleBox("Ngày kết thúc"),
                    ],
                  ),
                  SizedBox(height: 8),
                  BlocProvider<ClassStudentCubit>.value(
                    value: _classStudentCubit,
                    child: BlocListener<ClassStudentCubit, ClassStudentState>(
                      listener: (context, state) {
                        if (state is ClassGetLoaded) {
                          setState(() {
                            classCheckBox = _classStudentCubit.classListRegister
                                .map((infoClass) => infoClass.class_id)
                                .toList();
                          });
                        }
                      },
                      child: BlocBuilder<ClassStudentCubit, ClassStudentState>(
                          bloc: _classStudentCubit,
                          builder: (context, state) {
                            logger.log("STATE ${state}");
                            if (state is ClassGetLoaded) {
                              logger.log("classCheckBox ${classCheckBox}");
                              return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.white),
                                  ),
                                  child: Column(
                                    children: _classStudentCubit
                                        .classListRegister
                                        .map((data) {
                                      return Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            child: Center(
                                              child: Checkbox(
                                                fillColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.white),
                                                checkColor: Colors.red,
                                                activeColor: Colors.red,
                                                value: classCheckBox
                                                    .contains(data.class_id),
                                                onChanged: (bool? value) {
                                                  toggleClassCheck(
                                                      data.class_id);
                                                },
                                              ),
                                            ),
                                          ),
                                          _buildContentBox(data.class_id),
                                          _buildContentBox(""),
                                          _buildContentBox(data.class_name),
                                          _buildContentBox(data.lecturer_name ==
                                                  ""
                                              ? "Mã gvien: ${data.lecturer_id}"
                                              : data.lecturer_name),
                                          _buildContentBox(data.status),
                                          _buildContentBox(data.start_date),
                                          _buildContentBox(data.end_date),
                                        ],
                                      );
                                    }).toList(),
                                  ));
                            }
                            if (state is ClassGetLoading) {
                              return SizedBox();
                            } else {
                              return Center(
                                child: Text(
                                  'Sinh viên chưa đăng ký lớp',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buttonColors(context, "Gửi đăng ký", 14, () async {
                        await _classStudentCubit.registerClass(classCheckBox);
                      }),
                      SizedBox(width: 8),
                      buttonColors(context, "Xóa lớp", 14, () async {
                        if (classCheckBox.length > 1) {
                          showToastErr(message: "Chỉ được chọn 1 lớp để xóa");
                        } else {
                          await _classStudentCubit
                              .deleteClass(classCheckBox[0]);
                          // await _classStudentCubit.getListClass();
                        }
                      }),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitleBox(String title) {
    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.redDelete,
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  // Widget ô nội dung
  Widget _buildContentBox(String content) {
    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Checkbox Widget
  Widget _buildCheckbox(String class_id) {
    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Checkbox(
          activeColor: Colors.white,
          value: false,
          onChanged: (bool? value) {},
        ),
      ),
    );
  }
}
