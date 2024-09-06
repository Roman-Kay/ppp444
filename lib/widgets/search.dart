import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppp444/widgets/custom_textfiled_label.dart';

class Search extends StatelessWidget {
  final TextEditingController searchController;
  const Search({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: searchController,
      hintText: 'Search...',
      iconLeft: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: SvgPicture.asset('assets/images/search.svg'),
      ),
    );
  }
}
