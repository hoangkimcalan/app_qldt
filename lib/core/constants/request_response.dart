import 'dart:async';
import 'dart:convert';

import 'package:app_qldt_hust/core/constants/status_code.dart';
import 'package:app_qldt_hust/core/error_handling/error_response.dart';
import 'package:app_qldt_hust/core/error_handling/exception_error.dart';
import 'package:flutter/foundation.dart';

class RequestResponse {
  final String data;
  int? code;
  bool? result;
  ErrorResponse? error;

  RequestResponse(this.data, this.result, this.code, {this.error}) {
    setError(data.toString());
  }

  // hiển thị lỗi
  void setError(String strResponse) {
    try {
      var res = json.decode(strResponse);

      if (res['error'] is String) {
        error = ErrorResponse(message: res['error']);
      } else {
        error =
            res['error'] != null ? ErrorResponse.fromJson(res["error"]) : null;
      }
    } catch (e) {
      ErrorResponse error = ErrorResponse(
        code: StatusCode.errorUnknownCode,
        message: 'Đã có lỗi xảy ra, vui lòng thử lại sau.',
      );
      this.error = error;
    }
  }

  bool get hasError => !(this.result == true && this.error == null);

  /// Handle response [this] khi trả về
  ///
  /// [callBack]: thường là chuyển đổi từ [response] => model
  ///
  /// Trả về [CustomException] nếu [this].hasError = true hoặc [callBack] có lỗi
  ///
  /// Nếu [predicate] = true => return [callBack]
  FutureOr<T> onCallBack<T>(
    FutureOr<T> Function(RequestResponse) callBack, {
    bool Function()? predicate,
    bool multiThread = false,
  }) async {
    if (predicate?.call() ?? !this.hasError) {
      try {
        return !multiThread
            ? await callBack(this)
            : await compute(_compute, [this, callBack]);
      } catch (e) {
        throw CustomException();
      }
    } else {
      throw CustomException(this.error);
    }
  }

  static FutureOr<T> _compute<T>(List param) =>
      (param[1] as FutureOr<T> Function(RequestResponse)).call(param[0]);
}

class CustomException implements Exception {
  final ExceptionError error;

  CustomException([ExceptionError? error])
      : this.error = error ?? ExceptionError.unknown();

  @override
  String toString() => 'Exception: $error';
}
