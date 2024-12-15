import 'dart:io';

import 'package:app_qldt_hust/core/constants/api_path.dart';
import 'package:app_qldt_hust/core/constants/request_response.dart';
import 'package:app_qldt_hust/core/functions/api_client.dart';
import 'package:dio/dio.dart';

class AssignmentRepository {
  Future<RequestResponse> getAllSurveys({
    required String token,
    required String class_id,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.getAllSurveys,
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

  Future<RequestResponse> createAssignment({
    required String token,
    required String class_id,
    required String title,
    required String description,
    required String deadline,
    required File file,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      List<MultipartFile> multiPartFile = [];
      multiPartFile.add(await MultipartFile.fromFile(file.absolute.path));
      res = await ApiClient().request(
        isFormData: true,
        url: ApiPath.createSurveys,
        method: "POST",
        data: {
          "token": token,
          "classId": class_id,
          "title": title,
          "description": description,
          "deadline": deadline,
          "file": multiPartFile,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> editAssigment({
    required String token,
    required String assignmentId,
    required String title,
    required String description,
    required String deadline,
    required File file,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      List<MultipartFile> multiPartFile = [];
      multiPartFile.add(await MultipartFile.fromFile(file.absolute.path));
      res = await ApiClient().request(
        isFormData: true,
        url: ApiPath.editSurveys,
        method: "POST",
        data: {
          "token": token,
          "assignmentId": assignmentId,
          "title": title,
          "description": description,
          "deadline": deadline,
          "file": multiPartFile,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> submitAssigment({
    required String token,
    required String assignmentId,
    required String textResponse,
    required File file,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      List<MultipartFile> multiPartFile = [];
      multiPartFile.add(await MultipartFile.fromFile(file.absolute.path));
      res = await ApiClient().request(
        isFormData: true,
        url: ApiPath.submitSurveys,
        method: "POST",
        data: {
          "token": token,
          "assignmentId": assignmentId,
          "textResponse": textResponse,
          "file": multiPartFile,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }

  Future<RequestResponse> getSubmission({
    required String token,
    required String assignment_id,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.getsubmitSurveys,
        method: "POST",
        data: {
          "token": token,
          "assignment_id": assignment_id,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }
}
