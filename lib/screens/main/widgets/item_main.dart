import 'package:app_qldt_hust/core/theme/colors.dart';
import 'package:flutter/material.dart';

InkWell itemMain(
    {required String title, required IconData icon, VoidCallback? callback}) {
  return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: AppShadow.shadow,
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.red),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  overflow:
                      TextOverflow.ellipsis, // Prevents overflow with ellipsis
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ));
}
