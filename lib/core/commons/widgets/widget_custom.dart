import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:flutter/material.dart';

CustomLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Center(
        child: CircularProgressIndicator(
      color: AppColors.white,
    )),
  );
}
