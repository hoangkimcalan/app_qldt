part of 'attendance_cubit.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

//upload
class TakeAttendanceInitial extends AttendanceState {}

class TakeAttendanceLoading extends AttendanceState {}

class TakeAttendanceLoaded extends AttendanceState {}

class TakeAttendanceEmpty extends AttendanceState {}

class TakeAttendanceError extends AttendanceState {
  final String error;

  const TakeAttendanceError({
    required this.error,
  });
}
