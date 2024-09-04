// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/ui/settings/settings_main_screen.dart';
import 'package:ppp444/ui/wardrobe/wardrobe_main_screen.dart';
import 'package:ppp444/utils/colors.dart';

Widget bottomBarItem(final String svgName, final bool isChoose, final Function()? onPressed) {
  return IconButton(
    onPressed: onPressed,
    icon: SvgPicture.asset(
      'assets/images/$svgName.svg',
      color: isChoose ? AppColors.primaryColor : AppColors.greyColor,
      height: 32,
    ),
  );
}

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  static List<Widget> screen = <Widget>[
    WardrobeMainScreen(),
    const SizedBox(),
    const SettingsMainScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screen[selectedIndex],
      ),
      bottomNavigationBar: Container(
        height: 50.h + MediaQuery.of(context).padding.bottom,
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          border: Border(
            top: BorderSide(color: AppColors.linesColor, width: 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomBarItem(
                'bottom_bar_wardrobe',
                selectedIndex == 0,
                () => setState(() => selectedIndex = 0),
              ),
              bottomBarItem(
                'bottom_bar_clothes',
                selectedIndex == 1,
                () => setState(() => selectedIndex = 1),
              ),
              bottomBarItem(
                'bottom_bar_settings',
                selectedIndex == 2,
                () => setState(() => selectedIndex = 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
