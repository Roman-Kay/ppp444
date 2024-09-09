import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/widgets/custom_textfiled_label.dart';

void showCustomDialog(
  BuildContext context,
  String name,
  String title,
  void Function()? onPressed,
  void Function()? onPressedCancel,
  final TextEditingController controller,
  final FutureOr Function(void) onValue,
) async {
  // final TextEditingController controller = TextEditingController();
  await showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 200.h),
        child: Theme(
          data: ThemeData.dark(),
          child: StatefulBuilder(builder: (context, setState) {
            return CupertinoAlertDialog(
              content: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.basicWhiteColor,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.basicWhiteColor,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Material(
                    borderRadius: BorderRadius.circular(7),
                    child: CustomTextField(
                      isCupertino: true,
                      hintText: name,
                      controller: controller,
                      onChanged: (val) => setState(
                        () {},
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: onPressedCancel,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A84FF),
                    ),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: onPressed,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: controller.text.isNotEmpty
                          ? const Color(0xFF0A84FF)
                          : const Color(0xFF5A5960),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    ),
  ).then(onValue);
}
