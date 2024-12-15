import 'package:app_qldt_hust/core/constants/status_code.dart';
import 'package:app_qldt_hust/core/error_handling/exception_error.dart';

class ErrorResponse extends ExceptionError {
  ErrorResponse({
    int? code,
    String? message,
  })  : this.code = code ?? StatusCode.errorUnknownCode,
        this.messages = message ?? 'Đã có lỗi xảy ra, vui lòng thử lại sau.',
        super(message ?? 'Đã có lỗi xảy ra, vui lòng thử lại sau.', code: code);

  final int? code;
  final String? messages;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        code: int.tryParse(json["code"]?.toString() ?? ''),
        message: json["message"] ?? json['error'],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": messages,
      };

  @override
  String toString() => '$messages\n[$code]';
}
