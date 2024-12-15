import 'package:app_qldt_hust/core/blocs/auth/cubit/auth_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/widget_custom.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/screens/auth/login_screen.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sp_util/sp_util.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
  static String get routerConfig => '/register';
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthCubit _authCubit = AuthCubit();

  FocusNode _focusNode = FocusNode();
  ValueNotifier<bool> isShowPassWord = ValueNotifier(true);
  String? selectedRole = 'LECTURER';

  TextEditingController hoController = TextEditingController();
  TextEditingController tenController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

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
    hoController.dispose();
    tenController.dispose();
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    final ho = hoController.text.trim();
    final ten = tenController.text.trim();
    final email = emailController.text.trim();
    final password = pwController.text.trim();

    // Kiểm tra các trường bắt buộc
    if (ho.isEmpty || ten.isEmpty || email.isEmpty || password.isEmpty) {
      showToastErr(message: "Vui lòng nhập đầy đủ thông tin!");
      return;
    }

    // Kiểm tra định dạng email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      showToastErr(message: "Email không đúng định dạng!");
      return;
    }
    await _authCubit.register(
      ho: hoController.text,
      ten: tenController.text,
      email: emailController.text,
      password: pwController.text,
      role: selectedRole!,
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
              listener: (context, state) async {
                if (state is AuthLoading) {
                  CustomLoading(context);
                } else if (state is RegisterSuccess) {
                  showToastSuccess(message: "Đăng ký thành công");
                  await SpUtil.putString('email', state.email);
                  await SpUtil.putString('verify_code', state.verify_code);
                  context.push(LoginScreen.routerConfig);
                } else if (state is RegisterFailure) {
                  showToastErr(message: "Đã có lỗi xảy ra: ${state.message}");
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
                  Text("Welcome to AIIHUST",
                      style: TextStyle(color: AppColors.white, fontSize: 30)),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          focusNode: _focusNode,
                          style: TextStyle(color: Colors.white),
                          controller: hoController,
                          decoration: InputDecorationAuth("Họ"),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: tenController,
                          decoration: InputDecorationAuth("Tên"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  TextFormField(
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
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 20.0),
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
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Role",
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 20.0),
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
                    icon: Icon(
                      Icons.arrow_drop_down_circle, // Đặt icon tùy chỉnh
                      color: Colors.white, // Đặt màu của icon
                      size: 24, // Đặt kích thước của icon
                    ),
                    value: selectedRole,
                    items: [
                      DropdownMenuItem(
                          value: "LECTURER",
                          child: Text("Giảng viên",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 220, 182, 182),
                                  fontSize: 20.0))),
                      DropdownMenuItem(
                          value: "STUDENT",
                          child: Text("Sinh viên",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 220, 182, 182),
                                  fontSize: 20.0))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  buttonColors(context, "Đăng ký", 28, () async {
                    await onSubmit();
                  }),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      context.push(LoginScreen.routerConfig);
                    },
                    child: Text(
                      "Hoặc đăng nhập với tài khoản/mật khẩu",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
