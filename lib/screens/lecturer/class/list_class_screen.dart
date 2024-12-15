import 'package:app_qldt_hust/core/blocs/lecturer/class/cubit/class_cubit.dart';
import 'package:app_qldt_hust/core/models/lecturer/class/info_class.dart';
import 'package:app_qldt_hust/core/theme/app_dimens.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/lecturer/class/create_class_screen.dart';
import 'package:app_qldt_hust/screens/lecturer/class/info_class_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ListClassScreen extends StatefulWidget {
  const ListClassScreen({super.key});

  @override
  State<ListClassScreen> createState() => _ListClassScreenState();
  static String get routerConfig => '/list_class';
}

class _ListClassScreenState extends State<ListClassScreen> {
  late ClassCubit _classCubit = ClassCubit();

  @override
  void initState() {
    _classCubit.getListClass();
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
            child: Text("Danh sách lớp học", style: TextStyles.text18w6white),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                size: 28,
                Icons.add,
                color: AppColors.white,
              ),
              onPressed: () async {
                await context.push(CreateClassScreen.routerConfig);
                _classCubit.getListClass();
              },
            )
          ],
        ),
        body: BlocProvider<ClassCubit>.value(
          value: _classCubit,
          child: BlocBuilder<ClassCubit, ClassState>(
            bloc: _classCubit,
            builder: (context, state) {
              if (state is ClassGetLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await _classCubit
                        .getListClass(); // Gọi API reload danh sách
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                    itemCount: _classCubit.classList.length,
                    itemBuilder: (context, index) =>
                        infoClass(context, _classCubit.classList[index]),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "Chưa có lớp nào, vui lòng tạo lớp mới",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                );
              }
            },
          ),
        ));
  }

  Widget infoClass(BuildContext context, InfoClass infoClass) {
    return GestureDetector(
      onTap: () {
        context.push(
          InfoClassScreen.routerConfig,
          extra: infoClass,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppDimens.space15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.space15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: AppShadow.shadow),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 8),
              SizedBox(
                width: 30,
                height: 30,
                child: Icon(Icons.class_outlined, color: Colors.red),
              ),
              const Spacer(flex: 8),
              Expanded(
                flex: 290,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mã lớp: ${infoClass.class_id}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: AppDimens.space5,
                    ),
                    Text(
                      'Tên lớp: ${infoClass.class_name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: AppDimens.space5,
                    ),
                    Text(
                      'Loại lớp: ${infoClass.class_type}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: AppDimens.space5,
                    ),
                    Text(
                      'Giảng viên: ${infoClass.lecturer_name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: AppDimens.space5,
                    ),
                    Text(
                      'Số lượng SV: ${infoClass.student_count}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
