import 'dart:convert';

import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/repos/attendance/attendance_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sp_util/sp_util.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  AttendanceRepository attendanceRepository = AttendanceRepository();

  Future<void> takeAttendance(
    String token,
    String class_id,
    String date,
    List<String> attendance_list,
  ) async {
    try {
      emit(TakeAttendanceLoading());
      final response = await attendanceRepository.takeAttendance(
        token: SpUtil.getString("token")!,
        class_id: class_id,
        date: date,
        attendance_list: attendance_list,
      );

      final resultDecoded = jsonDecode(response.data);
      logger.log("resultDecoded ${resultDecoded}", name: "takeAttendance");
      if (resultDecoded["meta"]["code"] == "1000") {
      } else {
        emit(TakeAttendanceError(error: resultDecoded["meta"]["message"]));
      }
    } catch (e, s) {
      logger.log("VAO DAY ${e} ${s}");
      emit(TakeAttendanceError(error: '$e $s'));
    }
  }
}
