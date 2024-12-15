part of 'material_cubit.dart';

sealed class MaterialState extends Equatable {
  const MaterialState();

  @override
  List<Object> get props => [];
}

final class MaterialInitial extends MaterialState {}

//danh sach
class MaterialGetInitial extends MaterialState {}

class MaterialGetLoading extends MaterialState {}

class MaterialGetLoaded extends MaterialState {
  final List<InfoMaterial> listMaterial;
  const MaterialGetLoaded({required this.listMaterial});

  @override
  List<Object> get props => [listMaterial];
}

class MaterialGetEmpty extends MaterialState {}

class MaterialGetError extends MaterialState {
  final String error;

  const MaterialGetError({
    required this.error,
  });
}

//upload
//danh sach
class MaterialUploadInitial extends MaterialState {}

class MaterialUploadLoading extends MaterialState {}

class MaterialUploadLoaded extends MaterialState {
  final InfoMaterial infoMaterial;
  const MaterialUploadLoaded({required this.infoMaterial});

  @override
  List<Object> get props => [infoMaterial];
}

class MaterialUploadEmpty extends MaterialState {}

class MaterialUploadError extends MaterialState {
  final String error;

  const MaterialUploadError({
    required this.error,
  });
}

//edit
class EditMaterialInitial extends MaterialState {}

class EditMaterialLoading extends MaterialState {}

class EditMaterialLoaded extends MaterialState {
  final InfoMaterial infoMaterial;

  const EditMaterialLoaded({required this.infoMaterial});

  @override
  List<Object> get props => [infoMaterial];
}

class EditMaterialError extends MaterialState {
  final String error;

  const EditMaterialError(this.error);

  @override
  List<Object> get props => [error];
}

class DeleteMaterialLoading extends MaterialState {}

class DeleteMaterialLoaded extends MaterialState {}

class DeleteMaterialError extends MaterialState {
  final String error;

  const DeleteMaterialError(this.error);

  @override
  List<Object> get props => [error];
}

class DeleteMaterialEmpty extends MaterialState {}
