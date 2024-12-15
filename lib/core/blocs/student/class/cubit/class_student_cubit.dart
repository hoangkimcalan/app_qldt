import 'dart:convert';

import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/models/student/class/info_class.dart';
import 'package:app_qldt_hust/core/repos/student/class/class_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sp_util/sp_util.dart';

part 'class_student_state.dart';

class ClassStudentCubit extends Cubit<ClassStudentState> {
  ClassStudentCubit() : super(ClassStudentInitial());

  List<InfoClassStudent> classListRegister = [];
  List<String> checkboxclassRegister = [];
  InfoClassStudent infoClassRegister =
      InfoClassStudent("", "", "", "", "", "", "", "", "");

  final ClassRepository classRepository = ClassRepository();

  Future<void> getBasicClassInfo({required String class_id}) async {
    try {
      emit(ClassStudentLoading());
      logger.log("token ${SpUtil.getString("token")!}");

      final respose = await classRepository.getBasicClassInfo(
        role: SpUtil.getString("role")!,
        token: SpUtil.getString("token")!,
        account_id: SpUtil.getString("id")!,
        class_id: class_id,
      );

      final resultDecoded = jsonDecode(respose.data);
      logger.log("resultDecoded ${resultDecoded}", name: "getBasicClassInfo");
      if (resultDecoded["meta"]["code"] == "1000") {
        logger.log("VAODAYY", name: "getBasicClassInfo");

        infoClassRegister = InfoClassStudent.fromJson(resultDecoded["data"]);

        classListRegister.add(infoClassRegister);

        emit(ClassGetLoaded(listClassGet: classListRegister));
      } else {
        emit(ClassGetError(error: resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      emit(ClassStudentError(error: '$e $s'));
    }
  }

  Future<void> getListClass() async {
    try {
      emit(ClassGetLoading());
      logger.log("token ${SpUtil.getString("token")!}");

      final respose = await classRepository.getClassList(
        role: SpUtil.getString("role")!,
        token: SpUtil.getString("token")!,
        account_id: SpUtil.getString("id")!,
      );

      final resultDecoded = jsonDecode(respose.data);
      logger.log("resultDecoded ${resultDecoded}", name: "getListClass");
      if (resultDecoded["meta"]["code"] == "1000") {
        logger.log("VAODAYY ${resultDecoded["data"]["page_content"]}",
            name: "getListClass");

        classListRegister = List.from(resultDecoded["data"]["page_content"])
            .map((e) => InfoClassStudent.fromJson(e))
            .toList();

        logger.log("VAODAYY ${classListRegister}", name: "getListClass");
        if (classListRegister.isEmpty) {
          emit(ClassGetEmpty());
        } else {
          emit(ClassGetLoaded(
            listClassGet: classListRegister,
          ));
        }
      } else {
        emit(ClassGetError(error: resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      emit(ClassGetError(error: '$e $s'));
    }
  }

  Future<void> registerClass(List<String> class_ids) async {
    try {
      emit(ClassGetLoading());
      logger.log("token ${SpUtil.getString("token")!}");
      logger.log("token ${class_ids}");

      final respose = await classRepository.registerClass(
        token: SpUtil.getString("token")!,
        class_ids: class_ids,
      );

      final resultDecoded = jsonDecode(respose.data);
      logger.log("resultDecoded ${resultDecoded["meta"]["code"] == "1000"}",
          name: "registerClass");
      if (resultDecoded["meta"]["code"] == "1000") {
        logger.log("VAODAYY 1111", name: "getListClass");

        logger.log("VAODAYY ${classListRegister}", name: "getListClass");
        if (classListRegister.isEmpty) {
          emit(ClassGetEmpty());
        } else {
          emit(ClassGetLoaded(
            listClassGet: classListRegister,
          ));
        }
      } else {
        emit(ClassGetError(error: resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      emit(ClassGetError(error: '$e $s'));
    }
  }

  Future<void> deleteClass(String class_id) async {
    try {
      emit(ClassGetLoading());
      logger.log("token ${SpUtil.getString("token")!}");
      logger.log("token ${class_id}");

      final respose = await classRepository.deleteClass(
        token: SpUtil.getString("token")!,
        role: SpUtil.getString("role")!,
        class_id: class_id,
        account_id: SpUtil.getString("id")!,
      );

      final resultDecoded = jsonDecode(respose.data);
      logger.log("resultDecoded ${resultDecoded["meta"]["code"] == "1000"}",
          name: "registerClass");
      if (resultDecoded["meta"]["code"] == "1000") {
        logger.log("VAODAYY 1111", name: "getListClass");

        logger.log("VAODAYY ${classListRegister}", name: "getListClass");
        if (classListRegister.isEmpty) {
          emit(ClassGetEmpty());
        } else {
          emit(ClassGetLoaded(
            listClassGet: classListRegister,
          ));
        }
      } else {
        emit(ClassGetError(error: resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      emit(ClassGetError(error: '$e $s'));
    }
  }
}
