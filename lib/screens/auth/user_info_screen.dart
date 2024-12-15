import 'dart:io';

import 'package:app_qldt_hust/core/blocs/auth/cubit/auth_cubit.dart';
import 'package:app_qldt_hust/core/models/auth/info_user.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/core/theme/text_style.dart';
import 'package:app_qldt_hust/screens/auth/login_screen.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sp_util/sp_util.dart';

class UserInfoScreen extends StatefulWidget {
  final InfoUser infoUser;
  const UserInfoScreen({super.key, required this.infoUser});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();

  static String get routerConfig => '/user_info';
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  AuthCubit authCubit = AuthCubit();
  late File fileUpLoad;
  bool hasPickedFile = false;

  _pickerFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
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
      setState(() {
        hasPickedFile = true; // Đánh dấu rằng ảnh đã được chọn
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redDelete,
      appBar: AppBar(
        backgroundColor: AppColors.redDelete,
        centerTitle: false,
        title: InkWell(
          child: Text("Hồ sơ cá nhân", style: TextStyles.text18w6white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: _pickerFile,
              child: Container(
                child: hasPickedFile
                    ? ClipOval(
                        child: Image.file(
                          fileUpLoad,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : widget.infoUser.avatar != ""
                        ? ClipOval(
                            child: Image.network(
                              widget.infoUser.avatar,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.person, size: 80),
                            ),
                          )
                        : ClipOval(
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                          ),
              ),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.white,
                  boxShadow: AppShadow.shadowBlu18),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Họ tên: ${widget.infoUser.name}",
                            style: TextStyles.text15w5Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Địa chỉ gmail: ${widget.infoUser.email}",
                            style: TextStyles.text15w5Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Trạng thái: ${widget.infoUser.status}",
                            style: TextStyles.text15w5Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            buttonColors(context, "Đăng xuất", 16, () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Colors.red, size: 50),
                      const SizedBox(height: 15.0),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Bạn chắc chắn muốn đăng xuất không ?",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, color: AppColors.red),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buttonColors(context, "Hủy", 20, () {
                            Navigator.pop(context);
                          }),
                          const SizedBox(width: 10.0),
                          buttonColors(context, "Có", 20, () async {
                            await SpUtil.clear();
                            GoRouter.of(context).go(LoginScreen.routerConfig);
                          }),
                        ],
                      )
                    ],
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
