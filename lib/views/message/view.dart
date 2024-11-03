import 'package:rivus_user/common/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/views/message/index.dart';

import 'chat/widgets/message_list.dart';
import 'package:get/get.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MessageController());
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
      body: const MessageList(),
    );
  }
}
