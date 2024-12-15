import 'dart:convert';
import 'dart:io';

import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/models/assignment/info_assignment.dart';
import 'package:app_qldt_hust/core/repos/assignment/assignment_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sp_util/sp_util.dart';

part 'assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit() : super(AssignmentInitial());

  final AssignmentRepository assignmentRepository = AssignmentRepository();

  List<InfoAssignment> assignmentList = [];
  InfoAssignment infoAssignment = InfoAssignment(1, "", "", 1, "", "", "");

  Future<void> getListAssignment(String class_id) async {
    try {
      emit(AssignmentGetLoading());
      final response = await assignmentRepository.getAllSurveys(
        token: SpUtil.getString("token")!,
        class_id: class_id,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "getListAssignment");
      if (resultDecoded["meta"]["code"] == "1000") {
        assignmentList = List.from(resultDecoded["data"])
            .map((e) => InfoAssignment.fromJson(e))
            .toList();
        emit(AssignmentGetLoaded(listAssignment: assignmentList));
      } else {
        emit(AssignmentGetError(error: resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      logger.log("VAO DAY ${e} ${s}");
      emit(AssignmentGetError(error: '$e $s'));
    }
  }

  Future<void> createAssignment(
    String class_id,
    String title,
    String description,
    String deadline,
    File file,
  ) async {
    try {
      emit(AssignmentUploadLoading());
      final response = await assignmentRepository.createAssignment(
        token: SpUtil.getString("token")!,
        class_id: class_id,
        title: title,
        description: description,
        deadline: deadline,
        file: file,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "createAssignment");
      if (resultDecoded["meta"]["code"] == "1000") {
        emit(AssignmentUploadLoaded());
      } else {
        emit(AssignmentUploadError(error: resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      logger.log("VAO DAY ${e} ${s}");
      emit(AssignmentUploadError(error: '$e $s'));
    }
  }

  Future<void> editAssignment(
    String assignmentId,
    String title,
    String description,
    String deadline,
    File file,
  ) async {
    try {
      emit(AssignmentEditLoading());
      final response = await assignmentRepository.editAssigment(
        token: SpUtil.getString("token")!,
        assignmentId: assignmentId,
        title: title,
        description: description,
        deadline: deadline,
        file: file,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "editAssignment");
      if (resultDecoded["meta"]["code"] == "1000") {
        emit(AssignmentEditLoaded());
      } else {
        emit(AssignmentEditError(error: resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      logger.log("VAO DAY ${e} ${s}");
      emit(AssignmentEditError(error: '$e $s'));
    }
  }

  Future<void> submitAssignment(
    String assignmentId,
    String textResponse,
    File file,
  ) async {
    try {
      emit(AssignmentSubmitLoading());
      final response = await assignmentRepository.submitAssigment(
        token: SpUtil.getString("token")!,
        assignmentId: assignmentId,
        file: file,
        textResponse: textResponse,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "submitAssignment");
      if (resultDecoded["meta"]["code"] == "1000") {
        emit(AssignmentSubmitLoaded());
      } else {
        emit(AssignmentSubmitError(error: resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      logger.log("VAO DAY ${e} ${s}");
      emit(AssignmentSubmitError(error: '$e $s'));
    }
  }

  Future<Map<String, dynamic>> getsubmitAssignment(
    String assignment_id,
  ) async {
    try {
      final response = await assignmentRepository.getSubmission(
        token: SpUtil.getString("token")!,
        assignment_id: assignment_id,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "getsubmitAssignment");
      if (resultDecoded["meta"]["code"] == "1000") {
        return {
          "success": true,
          "data": resultDecoded,
          "error": null,
        };
      } else {
        return {
          "success": false,
          "data": null,
          "error": resultDecoded["meta"]["message"],
        };
      }
    } catch (e, s) {
      logger.log("VAO DAY ${e} ${s}");
      return {
        "success": false,
        "data": null,
        "error": "Lỗi khi gọi API: $e",
      };
    }
  }
}
