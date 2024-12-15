import 'dart:convert';
import 'dart:io';

import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/models/material/info_material.dart';
import 'package:app_qldt_hust/core/repos/material/material_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sp_util/sp_util.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialState> {
  MaterialCubit() : super(MaterialInitial());

  final MaterialRepository materialRepository = MaterialRepository();

  List<InfoMaterial> materialList = [];
  InfoMaterial infoMaterial = InfoMaterial("", "", "", "", "", "");

  Future<void> getListMaterial(String class_id) async {
    try {
      emit(MaterialGetLoading());
      final response = await materialRepository.getMaterialList(
        token: SpUtil.getString("token")!,
        class_id: class_id,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "getListMaterial");
      if (resultDecoded["code"] == "1000") {
        materialList = List.from(resultDecoded["data"])
            .map((e) => InfoMaterial.fromJson(e))
            .toList();
        emit(MaterialGetLoaded(listMaterial: materialList));
      } else {
        emit(MaterialGetError(error: resultDecoded["message"]));
      }
    } catch (e, s) {
      emit(MaterialGetError(error: '$e $s'));
    }
  }

  Future<void> uploadMaterial(
    String class_id,
    String title,
    String description,
    String materialType,
    File file,
  ) async {
    try {
      emit(MaterialUploadLoading());
      final response = await materialRepository.uploadMaterial(
        token: SpUtil.getString("token")!,
        class_id: class_id,
        title: title,
        description: description,
        materialType: materialType,
        file: file,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "uploadMaterial");
      if (resultDecoded["code"] == "1000") {
        infoMaterial = InfoMaterial.fromJson(resultDecoded["data"]);
        materialList.add(infoMaterial);

        emit(MaterialUploadLoaded(infoMaterial: infoMaterial));
      } else {
        emit(MaterialGetError(error: resultDecoded["message"]));
      }
    } catch (e, s) {
      emit(MaterialGetError(error: '$e $s'));
    }
  }

  Future<void> editMaterial(
    String materialId,
    String title,
    String description,
    String materialType,
    File file,
  ) async {
    try {
      emit(EditMaterialLoading());
      final response = await materialRepository.editMaterial(
        token: SpUtil.getString("token")!,
        materialId: materialId,
        title: title,
        description: description,
        materialType: materialType,
        file: file,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "editMaterial");
      if (resultDecoded["code"] == "1000") {
        infoMaterial = InfoMaterial.fromJson(resultDecoded["data"]);
        materialList.add(infoMaterial);

        emit(EditMaterialLoaded(infoMaterial: infoMaterial));
      } else {
        emit(EditMaterialError(resultDecoded["message"]));
      }
    } catch (e, s) {
      emit(EditMaterialError('$e $s'));
    }
  }

  Future<void> deleteMaterial(
    String material_id,
  ) async {
    try {
      emit(DeleteMaterialLoading());
      final response = await materialRepository.deleteMaterial(
        token: SpUtil.getString("token")!,
        material_id: material_id,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "deleteMaterial");
      if (resultDecoded["code"] == "1000") {
        emit(DeleteMaterialLoaded());
      } else {
        emit(DeleteMaterialError(resultDecoded["message"]));
      }
    } catch (e, s) {
      emit(DeleteMaterialError('$e $s'));
    }
  }
}
