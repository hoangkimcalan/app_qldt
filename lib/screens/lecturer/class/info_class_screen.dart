import 'package:app_qldt_hust/core/blocs/lecturer/class/cubit/class_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/models/lecturer/class/info_class.dart';
import 'package:app_qldt_hust/core/theme/app_dimens.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/assignment/list_assigment_screen.dart';
import 'package:app_qldt_hust/screens/attendance/take_attendance_screen.dart';
import 'package:app_qldt_hust/screens/lecturer/class/edit_class_screen.dart';
import 'package:app_qldt_hust/screens/lecturer/widgets/custom_dialog_class.dart';
import 'package:app_qldt_hust/screens/material/list_material_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfoClassScreen extends StatefulWidget {
  final InfoClass infoClass;

  const InfoClassScreen({
    super.key,
    required this.infoClass,
  });

  @override
  State<InfoClassScreen> createState() => _InfoClassScreenState();
  static String get routerConfig => '/info_class';
}

class _InfoClassScreenState extends State<InfoClassScreen> {
  late ClassCubit _classCubit = ClassCubit();

  @override
  void initState() {
    _classCubit.getInfoClass(class_id: widget.infoClass.class_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redDelete,
      appBar: AppBar(
        backgroundColor: AppColors.redDelete,
        centerTitle: true,
        title: InkWell(
          child: Text("Chi tiết lớp ${widget.infoClass.class_name}",
              style: TextStyles.text18w6white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              size: 28,
              Icons.edit,
              color: AppColors.white,
            ),
            onPressed: () async {
              context.push(
                EditClassScreen.routerConfig,
                extra: widget.infoClass,
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              width: 400,
              height: 400,
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.space15, horizontal: AppDimens.space15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: AppShadow.shadow),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Mã lớp: ${widget.infoClass.class_id}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Tên lớp: ${widget.infoClass.class_name}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Giảng viên: ${widget.infoClass.lecturer_name} (${widget.infoClass.lecturer_account_id})',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Loại lớp: ${widget.infoClass.class_type}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Thời gian',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Ngày bắt đầu: ${widget.infoClass.start_date}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Ngày kết thúc: ${widget.infoClass.end_date}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Mã code teams: ${widget.infoClass.attached_code}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Trạng thái: ${widget.infoClass.status}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Danh sách sinh viên:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        ..._classCubit.infoClass.student_accounts
                            .map((e) => Text(
                                  "${e.first_name} ${e.last_name}",
                                ))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      DeleteWarningDialog(context, "Xác nhận xóa lớp này ?",
                          () {
                        _classCubit.deleteClass(
                            class_id: widget.infoClass.class_id);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showToastSuccess(message: "Xóa lớp học thành công");
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: AppColors.red3333,
                        ),
                        Text(
                          'Xóa',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.red3333),
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                context.push(
                  ListMaterialScreen.routerConfig,
                  extra: {
                    "class_id": widget.infoClass.class_id,
                    "class_name": widget.infoClass.class_name
                  },
                );
              },
              child: Container(
                width: 400,
                height: 50,
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.space15, horizontal: AppDimens.space15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: AppShadow.shadow),
                child: Center(
                  child: Text(
                    'Tài liệu lớp học',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                context.push(
                  ListAssignmentScreen.routerConfig,
                  extra: {
                    "class_id": widget.infoClass.class_id,
                    "class_name": widget.infoClass.class_name
                  },
                );
              },
              child: Container(
                width: 400,
                height: 50,
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.space15, horizontal: AppDimens.space15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: AppShadow.shadow),
                child: Center(
                  child: Text(
                    'Bài tập lớp học',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                context.push(
                  TakeAttendanceScreen.routerConfig,
                  extra: widget.infoClass.class_id,
                );
              },
              child: Container(
                width: 400,
                height: 50,
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.space15, horizontal: AppDimens.space15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: AppShadow.shadow),
                child: Center(
                  child: Text(
                    'Điểm danh',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
