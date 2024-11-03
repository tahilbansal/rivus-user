import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rivus_user/common/entities/message.dart';
import 'package:rivus_user/common/shimmers/itemlist_shimmer.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/controllers/contact_controller.dart';
//import 'package:rivus_user/controllers/updates_controllers/preparing_controller.dart';
import 'package:rivus_user/hooks/fetchOrders.dart';
import 'package:rivus_user/models/client_orders.dart';
import 'package:rivus_user/views/message/controller.dart';
import 'package:rivus_user/views/orders/widgets/client_order_tile.dart';
import 'package:get/get.dart';

class PaidOrders extends HookWidget {
  const PaidOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(PreparingController());
    final hookResult = useFetchClientOrders('paymentStatus', 'Completed');
    List<ClientOrders>? orders = hookResult.data;
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;

    //controller.setOnStatusChangeCallback(refetch);
    final msgController = Get.put(MessageController());
    Get.put(ContactController());
    return Container(
      height: hieght / 1.3,
      width: width,
      color: kLightWhite,
      child: isLoading
          ? const ItemsListShimmer()
          : ListView.builder(
              padding: EdgeInsets.only(top: 10.h, left: 12.w, right: 12.w),
              itemCount: orders!.length,
              itemBuilder: (context, i) {
                ClientOrders order = orders[i];

                return ClientOrderTile(order: order);
              }),
    );
  }
}
