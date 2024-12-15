import 'package:app_qldt_hust/core/blocs/auth/cubit/auth_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/widget_custom.dart';
import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/screens/auth/register_screen.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:app_qldt_hust/screens/main/main_lecturer_screen.dart';
import 'package:app_qldt_hust/screens/main/main_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  static String get routerConfig => '/login';
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthCubit _authCubit = AuthCubit();

  ValueNotifier<bool> isShowPassWord = ValueNotifier(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _authCubit.close();
    _focusNode.dispose();
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    await _authCubit.login(
      context: context,
      email: emailController.text,
      password: pwController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redDelete,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener(
          bloc: _authCubit,
          listener: (context, state) {
            logger.log("STATE ${state}", name: "HH");
            if (state is AuthLoading) {
              CustomLoading(context);
            } else if (state is AuthLoaded) {
              if (state.infoUser.role == "LECTURER")
                context.push(MainLecturerScreen.routerConfig);
              else
                context.push(MainStudentScreen.routerConfig);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text("HUST",
                  style: TextStyle(color: AppColors.white, fontSize: 50)),
              SizedBox(height: 80),
              Text("Đăng nhập với tài khoản QLDT",
                  style: TextStyle(color: AppColors.white, fontSize: 24)),
              SizedBox(height: 40),
              TextFormField(
                focusNode: _focusNode,
                style: TextStyle(color: Colors.white),
                controller: emailController,
                decoration: InputDecorationAuth("Email"),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: pwController,
                style: TextStyle(color: Colors.white),
                obscureText: isShowPassWord.value,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      isShowPassWord.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isShowPassWord.value = !isShowPassWord.value;
                      });
                    },
                  ),
                  labelText: "Mật khẩu",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                textInputAction: TextInputAction.done,
                maxLines: 1,
              ),
              SizedBox(height: 30),
              buttonColors(context, "Đăng nhập", 28, () async {
                onSubmit();
              }),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  context.push(RegisterScreen.routerConfig);
                },
                child: Text(
                  "Chưa có tài khoản, đăng ký ngay",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 18),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
