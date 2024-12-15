import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:flutter/material.dart';

DeleteWarningDialog(BuildContext context, String text, VoidCallback? callback) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50),
          const SizedBox(height: 15.0),
          Container(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: AppColors.red),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buttonColors(context, "Hủy", 20, () {
                Navigator.pop(context);
              }),
              const SizedBox(width: 10.0),
              buttonColors(context, "Xóa", 20, callback!),
            ],
          )
        ],
      );
    },
  );
}
