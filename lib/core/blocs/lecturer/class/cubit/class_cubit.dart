import 'dart:convert';

import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/models/lecturer/class/info_class.dart';
import 'package:app_qldt_hust/core/repos/lecturer/class/class_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sp_util/sp_util.dart';

part 'class_state.dart';

class ClassCubit extends Cubit<ClassState> {
  ClassCubit() : super(ClassInitial());

  final ClassRepository classRepository = ClassRepository();

  List<InfoClass> classList = [];
  InfoClass infoClass = InfoClass("", "", "", "", "", "", "", "", "", "", []);

  Future<void> createClass({
    required String class_id,
    required String class_name,
    required String class_type,
    required String start_date,
    required String end_date,
    required int max_student,
  }) async {
    try {
      emit(ClassCreateLoading());

      final respose = await classRepository.createClass(
          token: SpUtil.getString("token")!,
          class_id: class_id,
          class_name: class_name,
          class_type: class_type,
          start_date: start_date,
          end_date: end_date,
          max_student_amount: max_student);

      final resultDecoded = jsonDecode(respose.data);
      logger.log("resultDecoded ${resultDecoded}", name: "CREATECLASS");
      if (resultDecoded["meta"]["code"] == "1000") {
        emit(ClassCreateLoaded());
      } else {
        emit(ClassCreateError(resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      emit(ClassCreateError('$e $s'));
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
      logger.log("resultDecoded ${resultDecoded["data"]["page_content"]}",
          name: "getListClass");
      if (resultDecoded["meta"]["code"] == "1000") {
        classList = List.from(resultDecoded["data"]["page_content"])
            .map((e) => InfoClass.fromJson(e))
            .toList();

        if (classList.isEmpty) {
          emit(ClassGetEmpty());
        } else {
          emit(ClassGetLoaded(listClassGet: classList));
        }
      } else {
        emit(ClassCreateError(resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      emit(ClassCreateError('$e $s'));
    }
  }

  Future<void> getInfoClass({required String class_id}) async {
    try {
      emit(ClassInfoLoading());
      logger.log("token ${SpUtil.getString("token")!}");

      final respose = await classRepository.getClassInfo(
        role: SpUtil.getString("role")!,
        token: SpUtil.getString("token")!,
        account_id: SpUtil.getString("id")!,
        class_id: class_id,
      );

      final resultDecoded = jsonDecode(respose.data);
      logger.log("resultDecoded ${resultDecoded}", name: "getListClass");
      if (resultDecoded["meta"]["code"] == "1000") {
        logger.log("VAODAYY", name: "getInfoClass");

        infoClass = InfoClass.fromJson(resultDecoded["data"]);

        logger.log("VAODAYY ${classList}", name: "getInfoClass");

        emit(ClassInfoLoaded(classInfo: infoClass));
      } else {
        emit(ClassCreateError(resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      logger.log("e, ${e} ${s}");
      emit(ClassCreateError('$e $s'));
    }
  }

  Future<void> editClass({
    required String class_id,
    required String class_name,
    required String status,
    required String start_date,
    required String end_date,
  }) async {
    try {
      emit(EditClassLoading());
      logger.log("token ${SpUtil.getString("token")!}");

      final respose = await classRepository.editClass(
        token: SpUtil.getString("token")!,
        class_id: class_id,
        class_name: class_name,
        status: status,
        start_date: start_date,
        end_date: end_date,
      );

      final resultDecoded = jsonDecode(respose.data);
      logger.log("resultDecoded ${resultDecoded}", name: "editClass");
      if (resultDecoded["meta"]["code"] == "1000") {
        logger.log("VAODAYY", name: "getInfoClass");

        infoClass = InfoClass.fromJson(resultDecoded["data"]);

        logger.log("VAODAYY ${classList}", name: "getInfoClass");

        emit(EditClassLoaded(classInfo: infoClass));
      } else {
        emit(EditClassError(resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      emit(EditClassError('$e $s'));
    }
  }

  Future<void> deleteClass({
    required String class_id,
  }) async {
    try {
      emit(DeleteClassLoading());
      logger.log("token ${SpUtil.getString("token")!}");

      final respose = await classRepository.deleteClass(
        role: SpUtil.getString("role")!,
        token: SpUtil.getString("token")!,
        class_id: class_id,
        account_id: SpUtil.getString("id")!,
      );

      final resultDecoded = jsonDecode(respose.data);
      logger.log("resultDecoded ${resultDecoded}", name: "deleteClass");
      if (resultDecoded["meta"]["code"] == "1000") {
        emit(DeleteClassLoaded());
      } else {
        emit(DeleteClassError(resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      emit(DeleteClassError('$e $s'));
    }
  }
}
