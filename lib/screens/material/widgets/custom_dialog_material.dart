import 'package:app_qldt_hust/core/blocs/material/cubit/material_cubit.dart';
import 'package:app_qldt_hust/core/commons/widgets/toast_custom.dart';
import 'package:app_qldt_hust/core/commons/widgets/widget_custom.dart';
import 'package:app_qldt_hust/core/helpers/logger.dart';
import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:app_qldt_hust/screens/auth/widgets/textformfield_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

DeleteWarningDialogMaterial(BuildContext context, String text,
    VoidCallback? callback, MaterialCubit materialCubit) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocListener(
        bloc: materialCubit,
        listener: (context, state) {
          logger.log("STATE DELETE ${state}");
          if (state is DeleteMaterialLoading) {
            CustomLoading(context);
          } else if (state is DeleteMaterialLoaded) {
            showToastSuccess(message: "Xóa tài liệu thành công");
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state is DeleteMaterialError) {
            showToastErr(message: state.error);
          }
        },
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          children: [
            const Icon(Icons.warning_amber_rounded,
                color: Colors.red, size: 50),
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
        ),
      );
    },
  );
}
