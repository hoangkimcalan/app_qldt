import 'dart:convert';

import 'package:app_qldt_hust/core/constants/api_path.dart';
import 'package:app_qldt_hust/core/constants/request_response.dart';
import 'package:app_qldt_hust/core/constants/status_code.dart';
import 'package:app_qldt_hust/core/error_handling/error_response.dart';
import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:dio/dio.dart';

class ApiClient {
  Dio _dio;

  // Constructor
  ApiClient({BaseOptions? options})
      : _dio = Dio(options ??
            BaseOptions(
              baseUrl: ApiPath.url,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ));

  // Hàm gọi API
  Future<RequestResponse> request({
    required String url,
    required String method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool isFormData = false, // Thêm tuỳ chọn FormData
  }) async {
    try {
      // Kết hợp headers từ tham số với headers mặc định
      _dio.options.headers.addAll(headers ?? {});

      // Xử lý data thành FormData nếu được yêu cầu
      dynamic requestData = isFormData ? FormData.fromMap(data ?? {}) : data;
      if (isFormData) logger.log("DATAAFROM ${requestData}");
      // Gọi API với phương thức tương ứng
      Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await _dio.get(url, queryParameters: data);
          break;
        case 'POST':
          response = await _dio.post(url, data: requestData);
          break;
        case 'PUT':
          response = await _dio.put(url, data: requestData);
          break;
        case 'DELETE':
          response = await _dio.delete(url, data: requestData);
          break;
        default:
          throw Exception('Unsupported HTTP method');
      }

      return RequestResponse(
        jsonEncode(response.data),
        true,
        response.statusCode ?? StatusCode.ok,
      );
    } on DioError catch (e) {
      String errorMessage = 'Lỗi, vui lòng thử lại sau';
      int statusCode = 0;

      var error = ErrorResponse(
          message: e.response?.data.toString() ?? errorMessage,
          code: e.response?.statusCode ?? statusCode);

      return RequestResponse(
        jsonEncode(e.response?.data),
        false,
        statusCode,
        error: error,
      );
    }
  }
}
