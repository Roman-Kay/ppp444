// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/widgets/widget_button.dart';

pickImageSheet(
  BuildContext context,
) {
  if (Platform.isIOS) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              final File? image = await getImage(ImageSource.gallery);
              Navigator.pop(context, image);
            },
            child: const Text(
              'Выбрать из галереи',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A84FF),
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final File? image = await getImage(ImageSource.camera);
              Navigator.pop(context, image);
            },
            child: const Text(
              'Сделать фото',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A84FF),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.basicWhiteColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.h),
                  WidgetButton(
                    text: 'Выбрать из галереи',
                    onPressed: () async {
                      final File? image = await getImage(ImageSource.gallery);
                      Navigator.pop(context, image);
                    },
                  ),
                  SizedBox(height: 20.h),
                  WidgetButton(
                    text: 'Сделать фото',
                    onPressed: () async {
                      final File? image = await getImage(ImageSource.camera);
                      Navigator.pop(context, image);
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Future getImage(ImageSource source) async {
  final XFile? image = await ImagePicker().pickImage(source: source);
  if (image == null) return;
  return image.path;
}
