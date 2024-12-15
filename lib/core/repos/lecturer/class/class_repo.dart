import 'package:app_qldt_hust/core/constants/api_path.dart';
import 'package:app_qldt_hust/core/constants/request_response.dart';
import 'package:app_qldt_hust/core/functions/api_client.dart';

class ClassRepository {
  Future<RequestResponse> createClass({
    required String token,
    required String class_id,
    required String class_name,
    required String class_type,
    required String start_date,
    required String end_date,
    required int max_student_amount,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.createClass,
        method: "POST",
        data: {
          "token": token,
          "class_id": class_id,
          "class_name": class_name,
          "class_type": class_type,
          "start_date": start_date.toString(),
          "end_date": end_date.toString(),
          "max_student_amount": max_student_amount
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> getClassList({
    required String token,
    required String role,
    required String account_id,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.getClassList,
        method: "POST",
        data: {
          "token": token,
          "role": token,
          "account_id": account_id,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> getClassInfo({
    required String token,
    required String role,
    required String account_id,
    required String class_id,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.getClassInfo,
        method: "POST",
        data: {
          "token": token,
          "role": role,
          "account_id": account_id,
          "class_id": class_id,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> editClass({
    required String token,
    required String class_id,
    required String class_name,
    required String status,
    required String start_date,
    required String end_date,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.editClass,
        method: "POST",
        data: {
          "token": token,
          "class_id": class_id,
          "class_name": class_name,
          "status": status,
          "start_date": start_date,
          "end_date": end_date,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> deleteClass({
    required String token,
    required String role,
    required String account_id,
    required String class_id,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.deleteClass,
        method: "POST",
        data: {
          "token": token,
          "role": role,
          "account_id": account_id,
          "class_id": class_id,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }
}
