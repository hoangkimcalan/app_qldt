import 'package:app_qldt_hust/core/blocs/auth/cubit/auth_cubit.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/auth/user_info_screen.dart';
import 'package:app_qldt_hust/screens/lecturer/class/list_class_screen.dart';
import 'package:app_qldt_hust/screens/main/widgets/item_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sp_util/sp_util.dart';

class MainLecturerScreen extends StatefulWidget {
  const MainLecturerScreen({super.key});

  @override
  State<MainLecturerScreen> createState() => _MainLecturerScreenState();

  static String get routerConfig => '/main_lecturer';
}

class _MainLecturerScreenState extends State<MainLecturerScreen> {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Xin chào giảng viên, ${state.infoUser.name}!",
                          style: TextStyles.text18w6white),
                      Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 10,
                          children: [
                            itemMain(
                                title: "Quản lý lớp học",
                                icon: Icons.create_new_folder,
                                callback: () {
                                  context.push(ListClassScreen.routerConfig);
                                }),
                            itemMain(
                                title: "Thông tin cá nhân",
                                icon: Icons.admin_panel_settings,
                                callback: () {
                                  context.push(UserInfoScreen.routerConfig,
                                      extra: state.infoUser);
                                }),
                          ],
                        ),
                      ),
                      Text("Ứng dụng quản lý đào tạo sinh viên ",
                          style: TextStyles.text18w6white),
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
