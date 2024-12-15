import 'package:app_qldt_hust/core/blocs/lecturer/class/cubit/class_cubit.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class TakeAttendanceScreen extends StatefulWidget {
  final String class_id;
  const TakeAttendanceScreen({super.key, required this.class_id});

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
  static String get routerConfig => '/take_attendance';
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  ClassCubit _classCubit = ClassCubit();

  @override
  void initState() {
    super.initState();
    // classCubit.getInfoClass(class_id: widget.class_id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redDelete,
      appBar: AppBar(
        backgroundColor: AppColors.redDelete,
        centerTitle: true,
        title: InkWell(
          child: Text(
            "Điểm danh",
            style: TextStyles.text18w6white,
          ),
        ),
      ),
    );
  }
}
