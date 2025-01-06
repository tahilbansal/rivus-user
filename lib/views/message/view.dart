import 'package:rivus_user/common/app_style.dart';
import 'package:rivus_user/common/search_bar.dart';
import 'package:rivus_user/common/search_results_page.dart';
import 'package:rivus_user/common/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/views/message/index.dart';
import 'package:rivus_user/views/search/seach_page.dart';
import 'chat/widgets/message_list.dart';
import 'package:get/get.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MessageController controller = Get.put(MessageController());
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimary,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Message",
            style: TextStyle(
                color: AppColors.primaryBackground,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          )),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => Get.to(() => SearchResultsPage()),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8.0),
                    Text(
                      "Search...",
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () {
                Get.to(() => const SearchPage(), arguments: {'focus': true});
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: kOffWhite,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: kGrayLight,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 2.0),
                    Text(
                      "Add Supplier >",
                      style: TextStyle(color: kPrimary, fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: const MessageList()),
          ],
        ),
      ),
    );
  }
}