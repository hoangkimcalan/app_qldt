import 'dart:io';

import 'package:app_qldt_hust/core/constants/api_path.dart';
import 'package:app_qldt_hust/core/constants/request_response.dart';
import 'package:app_qldt_hust/core/functions/api_client.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  Future<RequestResponse> authRegister({
    required String ho,
    required String ten,
    required String email,
    required String password,
    required int uuid,
    required String role,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.apiRegister,
        method: "POST",
        data: {
          'ho': ho,
          'ten': ten,
          'email': email,
          'password': password,
          'uuid': uuid,
          'role': role,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> authGetverifycode({
    required String email,
    required String password,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.apiGetverifycode,
        method: "POST",
        data: {
          'email': email,
          'password': password,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> authCheckverifycode({
    required String email,
    required String verifycode,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.apiCheckverifycode,
        method: "POST",
        data: {
          'email': email,
          'verify_code': verifycode,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> authLogin({
    required String email,
    required String password,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.apiLogin,
        method: "POST",
        data: {
          'email': email,
          'password': password,
          'device_id': 11111,
          'fcm_token': null
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> authGetUserInfo({
    required String token,
    required String user_id,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);
    try {
      res = await ApiClient().request(
        url: ApiPath.apiGetUserInfo,
        method: "POST",
        data: {
          'token': token,
          'user_id': user_id,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> changeAvatar({
    required String token,
    required File file,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);
    try {
      List<MultipartFile> multiPartFile = [];
      multiPartFile.add(await MultipartFile.fromFile(file.absolute.path));
      res = await ApiClient().request(
        url: ApiPath.apiChangeInfoAfterSignup,
        method: "POST",
        data: {
          'token': token,
          'file': multiPartFile,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }
}
