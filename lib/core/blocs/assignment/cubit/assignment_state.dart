part of 'assignment_cubit.dart';

sealed class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object> get props => [];
}

final class AssignmentInitial extends AssignmentState {}

//danh sach
class AssignmentGetInitial extends AssignmentState {}

class AssignmentGetLoading extends AssignmentState {}

class AssignmentGetLoaded extends AssignmentState {
  final List<InfoAssignment> listAssignment;
  const AssignmentGetLoaded({required this.listAssignment});

  @override
  List<Object> get props => [listAssignment];
}

class AssignmentGetEmpty extends AssignmentState {}

class AssignmentGetError extends AssignmentState {
  final String error;

  const AssignmentGetError({
    required this.error,
  });
}

//upload
class AssignmentUploadInitial extends AssignmentState {}

class AssignmentUploadLoading extends AssignmentState {}

class AssignmentUploadLoaded extends AssignmentState {}

class AssignmentUploadEmpty extends AssignmentState {}

class AssignmentUploadError extends AssignmentState {
  final String error;

  const AssignmentUploadError({
    required this.error,
  });
}

//edit
class AssignmentEditInitial extends AssignmentState {}

class AssignmentEditLoading extends AssignmentState {}

class AssignmentEditLoaded extends AssignmentState {}

class AssignmentEditEmpty extends AssignmentState {}

class AssignmentEditError extends AssignmentState {
  final String error;

  const AssignmentEditError({
    required this.error,
  });
}

//submit
class AssignmentSubmitInitial extends AssignmentState {}

class AssignmentSubmitLoading extends AssignmentState {}

class AssignmentSubmitLoaded extends AssignmentState {}

class AssignmentSubmitEmpty extends AssignmentState {}

class AssignmentSubmitError extends AssignmentState {
  final String error;

  const AssignmentSubmitError({
    required this.error,
  });
}

//get submit
class GetAssignmentSubmitInitial extends AssignmentState {}

class GetAssignmentSubmitLoading extends AssignmentState {}

class GetAssignmentSubmitLoaded extends AssignmentState {}

class GetAssignmentSubmitEmpty extends AssignmentState {}

class GetAssignmentSubmitError extends AssignmentState {
  final String error;

  const GetAssignmentSubmitError({
    required this.error,
  });
}
