part of 'class_cubit.dart';

sealed class ClassState extends Equatable {
  const ClassState();

  @override
  List<Object> get props => [];
}

final class ClassInitial extends ClassState {}

//them moi
class ClassCreateInitial extends ClassState {}

class ClassCreateLoading extends ClassState {}

class ClassCreateLoaded extends ClassState {}

class ClassCreateError extends ClassState {
  final String error;

  const ClassCreateError(this.error);

  @override
  List<Object> get props => [error];
}

//danh sach
class ClassGetInitial extends ClassState {}

class ClassGetLoading extends ClassState {}

class ClassGetLoaded extends ClassState {
  final List<InfoClass> listClassGet;

  const ClassGetLoaded({required this.listClassGet});

  @override
  List<Object> get props => [listClassGet];
}

class ClassGetEmpty extends ClassState {}

class ClassGetError extends ClassState {
  final String error;

  const ClassGetError({
    required this.error,
  });
}

//chi tiet

class ClassInfoInitial extends ClassState {}

class ClassInfoLoading extends ClassState {}

class ClassInfoLoaded extends ClassState {
  final InfoClass classInfo;

  const ClassInfoLoaded({required this.classInfo});

  @override
  List<Object> get props => [classInfo];
}

class ClassInfoError extends ClassState {
  final String error;

  const ClassInfoError({
    required this.error,
  });
}

//edit
class EditClassInitial extends ClassState {}

class EditClassLoading extends ClassState {}

class EditClassLoaded extends ClassState {
  final InfoClass classInfo;

  const EditClassLoaded({required this.classInfo});

  @override
  List<Object> get props => [classInfo];
}

class EditClassError extends ClassState {
  final String error;

  const EditClassError(this.error);

  @override
  List<Object> get props => [error];
}

class DeleteClassLoading extends ClassState {}

class DeleteClassLoaded extends ClassState {}

class DeleteClassError extends ClassState {
  final String error;

  const DeleteClassError(this.error);

  @override
  List<Object> get props => [error];
}

class DeleteClassEmpty extends ClassState {}
