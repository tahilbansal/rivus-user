import 'package:rivus_user/common/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/views/search/catalog_search_page.dart';
import 'package:rivus_user/views/search/seach_page.dart';
import 'package:get/get.dart';

class catalogSearchBar extends StatelessWidget {
  const catalogSearchBar({super.key,
      required this.supplierId});

  final String supplierId;

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () {
          Get.to(() => CatalogSearchPage(supplierId: supplierId), arguments: {'focus': true});
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: kGray),
              SizedBox(width: 8.w),
              Text(
                "Search Catalog",
                style: appStyle(14, kGray, FontWeight.w400),
              ),
            ],
          ),
        ),
      );
  }
}
