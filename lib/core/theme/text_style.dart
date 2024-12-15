import 'package:app_qldt_hust/core/theme/app_text_style.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle text12w4Black = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    height: 22 / 16,
  );
  static const TextStyle text12w4white = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 22 / 16,
  );
  static const TextStyle text12w4Red = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.red,
    height: 22 / 16,
  );

  static const TextStyle text15w5Black = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.black47,
    height: 22 / 16,
  );

  static const TextStyle text15w5doveGray = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.doveGray,
    height: 22 / 16,
  );

  static const TextStyle text15w5Blued4 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.blueD4,
    height: 22 / 16,
  );

  static const TextStyle text15w5Orange = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.orange13B,
    height: 22 / 16,
  );

  static const TextStyle text15w5White = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    height: 22 / 16,
  );

  static const TextStyle text16w5Gray = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.gray999,
    height: 22 / 16,
  );

  static const TextStyle text16w5black = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black47,
    height: 22 / 16,
  );

  static const TextStyle text16w6Black47 = TextStyle(
    height: 22 / 16,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black47,
  );

  static const TextStyle text16w6Orange = TextStyle(
    height: 22 / 16,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.orange,
  );

  static const TextStyle text16w6white = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle text17w5tundora = TextStyle(
    fontSize: 17,
    height: 23.12 / 23.12,
    fontWeight: FontWeight.w500,
    color: AppColors.tundora,
  );

  static const TextStyle text18w6white = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 22 / 16,
  );

  static const TextStyle text18w7Gray = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Color(0xFF666666),
    height: 22 / 16,
  );

  static const TextStyle text20w7Err = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.error,
    height: 22 / 16,
  );
  static const TextStyle text20w7white = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    height: 22 / 16,
  );

  static const TextStyle text35w7Orange = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w700,
    color: AppColors.orange,
    height: 22 / 16,
  );

  static const TextStyle appbarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  // thanh nhap trong cua so them/sua qr
  static InputDecoration nameTextFieldInputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    errorMaxLines: 2,
    errorStyle: const TextStyle(color: Colors.red, fontSize: 14),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    // suffixIcon: icon,
    contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
    border: InputBorder.none,
  );

  static TextStyle deleteWarningTextStyle = AppTextStyles.text.copyWith(
    color: AppColors.scarlet,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static TextStyle detailNameTextStyle = AppTextStyles.text.copyWith(
    color: AppColors.blue3B86D4,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static TextStyle organizationTextStyle = AppTextStyles.text.copyWith(
    color: AppColors.grey666,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );

  static TextStyle titleTextStyle = AppTextStyles.text.copyWith(
    color: AppColors.black47,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  static TextStyle chipTextStyle = AppTextStyles.text.copyWith(
    color: AppColors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
}
