import 'package:app_qldt_hust/core/blocs/auth/cubit/auth_cubit.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/auth/user_info_screen.dart';
import 'package:app_qldt_hust/screens/main/widgets/item_main.dart';
import 'package:app_qldt_hust/screens/student/class/list_class_student_screen.dart';
import 'package:app_qldt_hust/screens/student/class/register_class_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sp_util/sp_util.dart';

class MainStudentScreen extends StatefulWidget {
  const MainStudentScreen({super.key});

  @override
  State<MainStudentScreen> createState() => _MainStudentScreenState();

  static String get routerConfig => '/main_student';
}

class _MainStudentScreenState extends State<MainStudentScreen> {
  late AuthCubit _authCubit = AuthCubit();

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _authCubit.getUserInfo();
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
          onTap: () async {
            await SpUtil.clear();
          },
          child: Text("EHUST", style: TextStyles.text18w6white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<AuthCubit>.value(
          value: _authCubit,
          child: BlocBuilder<AuthCubit, AuthState>(
              bloc: _authCubit,
              builder: (context, state) {
                if (state is GetUserLoaded) {
                  return Column(
                    children: [
                      Text("Xin chào sinh viên, ${state.infoUser.name}!",
                          style: TextStyles.text18w6white),
                      SizedBox(height: 12),
                      Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 10,
                          children: [
                            itemMain(
                                title: "Đăng ký lớp học",
                                icon: Icons.app_registration,
                                callback: () {
                                  context
                                      .push(RegisterClassScreen.routerConfig);
                                }),
                            itemMain(
                                title: "Quản lý lớp học",
                                icon: Icons.manage_accounts,
                                callback: () {
                                  context.push(
                                      ListClassStudentScreen.routerConfig);
                                }),
                            itemMain(
                                title: "Thông tin cá nhân",
                                icon: Icons.create_new_folder,
                                callback: () {
                                  context.push(UserInfoScreen.routerConfig,
                                      extra: state.infoUser);
                                }),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  if (state is GetUserLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    );
                  } else {
                    return Text(
                      "Có lỗi xảy ra, vui lòng thử lại",
                      style: TextStyle(color: AppColors.white),
                    );
                  }
                }
              }),
        ),
      ),
    );
  }
}
