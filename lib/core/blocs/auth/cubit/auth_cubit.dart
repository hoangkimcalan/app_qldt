import 'dart:convert';
import 'dart:io';

import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/models/auth/info_user.dart';
import 'package:app_qldt_hust/core/repos/auth/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthRepository authRepository = AuthRepository();

  Future<void> register({
    required String ho,
    required String ten,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      emit(AuthLoading());
      final result = await authRepository.authRegister(
          ho: ho,
          ten: ten,
          email: email,
          password: password,
          uuid: 111111,
          role: role);
      final resultDecoded = jsonDecode(result.data);
      if (resultDecoded["code"] == "1000") {
        // String verify_code =
        //     await getverifycode(email: email, password: password);

        await checkverifycode(
            email: email, verifycode: resultDecoded["verify_code"]);

        emit(RegisterSuccess(
          verify_code: resultDecoded['verify_code'],
          email: email,
        ));
      } else {
        emit(RegisterFailure(resultDecoded['message']));
      }
    } catch (e) {
      logger.logError(e, "AUTH", "register()---AuthCubit");
    }
  }

  Future<String> getverifycode(
      {required String email, required String password}) async {
    try {
      final result = await authRepository.authGetverifycode(
        email: email,
        password: password,
      );
      final resultDecoded = jsonDecode(result.data);
      logger.log("getverifycode ${resultDecoded}");

      if (resultDecoded["code"] == "1000") {
        return resultDecoded['verify_code'];
      } else {
        return resultDecoded['message'];
      }
    } catch (e) {
      logger.logError(e, "AUTH", "register()---AuthCubit");
      return "ERROR";
    }
  }

  Future<void> checkverifycode(
      {required String email, required String verifycode}) async {
    try {
      final result = await authRepository.authCheckverifycode(
        email: email,
        verifycode: verifycode,
      );
      final resultDecoded = jsonDecode(result.data);
      logger.log("checkverifycode ${resultDecoded}");
    } catch (e) {
      logger.logError(e, "AUTH", "register()---AuthCubit");
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoading());
      final result = await authRepository.authLogin(
        email: email,
        password: password,
      );
      final resultDecoded = jsonDecode(result.data);
      logger.log("resultDecoded ${resultDecoded}", name: "AUTHLOGIN");
      if (resultDecoded["code"] == "1000") {
        logger.log("VAO DAYYY", name: "AUTHLOGIN");

        handleFetchDataUser(context: context, data: resultDecoded["data"]);
        emit(AuthLoaded(infoUser: InfoUser.fromJson(resultDecoded["data"])));
      } else {
        emit(RegisterFailure(resultDecoded['message']));
      }
    } catch (e) {
      logger.logError(e, "AUTH", "register()---AuthCubit");
    }
  }
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // dynamic idDevice;

  // Future<String> getDeviceInfo() async {
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     idDevice = androidInfo.id;
  //     SpUtil.putString('idDevice', idDevice);
  //     return idDevice;
  //   } else {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     idDevice = iosInfo.identifierForVendor;
  //     SpUtil.putString('idDevice', idDevice);
  //     return idDevice;
  //   }
  // }

  Future<void> handleFetchDataUser({
    required BuildContext context,
    required data,
  }) async {
    final InfoUser infoUser = InfoUser.fromJson(data);
    SpUtil.putString("id", infoUser.id);
    SpUtil.putString("email", infoUser.email);
    SpUtil.putString("name", infoUser.name);
    SpUtil.putString("token", infoUser.token);
    SpUtil.putString("role", infoUser.role);
    SpUtil.putString("status", infoUser.status);
    SpUtil.putString("avatar", infoUser.avatar);
  }

  Future<void> getUserInfo() async {
    try {
      String? tokenRf = SpUtil.getString("token");
      String? user_id = SpUtil.getString("id");
      String? email = SpUtil.getString("email");
      logger.log("TOKEN ${tokenRf} ${user_id} ${email}");
      emit(GetUserLoading());

      final result = await authRepository.authGetUserInfo(
        token: tokenRf!,
        user_id: user_id!,
      );
      final resultDecoded = jsonDecode(result.data);
      logger.log("resultDecoded ${resultDecoded}", name: "getUserInfo");
      if (resultDecoded["code"] == "1000") {
        emit(GetUserLoaded(infoUser: InfoUser.fromJson(resultDecoded["data"])));
      } else {
        emit(GetUserLoadError(error: resultDecoded['message']));
      }
    } catch (e) {
      logger.logError(e, "getUserInfo", "AUTHCUBIT");
      emit(GetUserLoadError(error: e.toString()));
    }
  }

  Future<String> changeAvatar({required File file}) async {
    try {
      final result = await authRepository.changeAvatar(
        file: file,
        token: SpUtil.getString("token")!,
      );
      final resultDecoded = jsonDecode(result.data);
      logger.log("getverifycode ${resultDecoded}");

      if (resultDecoded["code"] == "1000") {
        return resultDecoded['verify_code'];
      } else {
        return resultDecoded['message'];
      }
    } catch (e) {
      logger.logError(e, "AUTH", "register()---AuthCubit");
      return "ERROR";
    }
  }
}
