part of 'class_student_cubit.dart';

sealed class ClassStudentState extends Equatable {
  const ClassStudentState();

  @override
  List<Object> get props => [];
}

final class ClassStudentInitial extends ClassStudentState {}

//danh sach
class ClassGetInitial extends ClassStudentState {}

class ClassGetLoading extends ClassStudentState {}

class ClassGetLoaded extends ClassStudentState {
  final List<InfoClassStudent> listClassGet;

  const ClassGetLoaded({
    required this.listClassGet,
  });

  @override
  List<Object> get props => [listClassGet];
}

class ClassGetEmpty extends ClassStudentState {}

class ClassGetError extends ClassStudentState {
  final String error;

  const ClassGetError({
    required this.error,
  });
}

//chi tiet basic
class ClassStudentLoading extends ClassStudentState {}

class ClassStudentLoaded extends ClassStudentState {
  final InfoClassStudent classStudent;

  const ClassStudentLoaded({required this.classStudent});

  @override
  List<Object> get props => [classStudent];
}

class ClassStudentError extends ClassStudentState {
  final String error;

  const ClassStudentError({
    required this.error,
  });
}
