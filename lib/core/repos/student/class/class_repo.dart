import 'package:app_qldt_hust/core/constants/api_path.dart';
import 'package:app_qldt_hust/core/constants/request_response.dart';
import 'package:app_qldt_hust/core/functions/api_client.dart';

class ClassRepository {
  Future<RequestResponse> getBasicClassInfo({
    required String token,
    required String role,
    required String account_id,
    required String class_id,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.getBasicClassInfo,
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

  Future<RequestResponse> registerClass({
    required String token,
    required List<String> class_ids,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.registerClass,
        method: "POST",
        data: {
          "token": token,
          "class_ids": class_ids,
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
        url: ApiPath.deleteClassStudent,
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
