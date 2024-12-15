import 'dart:io';

import 'package:app_qldt_hust/core/constants/api_path.dart';
import 'package:app_qldt_hust/core/constants/request_response.dart';
import 'package:app_qldt_hust/core/functions/api_client.dart';
import 'package:dio/dio.dart';

class MaterialRepository {
  Future<RequestResponse> getMaterialList({
    required String token,
    required String class_id,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.getMaterialList,
        method: "POST",
        data: {
          "token": token,
          "class_id": class_id,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> uploadMaterial({
    required String token,
    required String class_id,
    required String title,
    required String description,
    required String materialType,
    required File file,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      print("VAO DAYYY");
      List<MultipartFile> multiPartFile = [];
      multiPartFile.add(await MultipartFile.fromFile(file.absolute.path));
      res = await ApiClient().request(
        isFormData: true,
        url: ApiPath.uploadMaterial,
        method: "POST",
        data: {
          "token": token,
          "classId": class_id,
          "title": title,
          "description": description,
          "materialType": materialType,
          "file": multiPartFile,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> editMaterial({
    required String token,
    required String materialId,
    required String title,
    required String description,
    required String materialType,
    required File file,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      List<MultipartFile> multiPartFile = [];
      multiPartFile.add(await MultipartFile.fromFile(file.absolute.path));
      res = await ApiClient().request(
        isFormData: true,
        url: ApiPath.editMaterial,
        method: "POST",
        data: {
          "token": token,
          "materialId": materialId,
          "title": title,
          "description": description,
          "materialType": materialType,
          "file": multiPartFile,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> deleteMaterial({
    required String token,
    required String material_id,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.deleteMaterial,
        method: "POST",
        data: {
          "token": token,
          "material_id": material_id,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }
}
