import 'package:app_qldt_hust/core/constants/api_path.dart';
import 'package:app_qldt_hust/core/constants/request_response.dart';
import 'package:app_qldt_hust/core/functions/api_client.dart';

class AttendanceRepository {
  Future<RequestResponse> takeAttendance({
    required String token,
    required String class_id,
    required String date,
    required List<String> attendance_list,
  }) async {
    RequestResponse res = new RequestResponse("", true, 400);

    try {
      res = await ApiClient().request(
        url: ApiPath.takeAttendance,
        method: "POST",
        data: {
          "token": token,
          "class_id": class_id,
          "date": date,
          "attendance_list": attendance_list,
        },
      );
      return res;
    } catch (e) {
      res.setError(e.toString());
      return res;
    }
  }
}
