import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/controllers/search_controller.dart';
import 'package:rivus_user/models/items.dart';
import 'package:rivus_user/views/item/widgets/item_tile.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CatalogSearchResults extends StatelessWidget {
  const CatalogSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(ItemSearchController());
    return Container(
      color: searchController.itemsResults!.isEmpty ||
          searchController.itemsResults == null
          ? kLightWhite
          : Colors.white,
      padding: EdgeInsets.only(left: 12.w, top: 10.h, right: 12.w),
      height: hieght,
      child: searchController.itemsResults!.isNotEmpty
          ? ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          itemCount: searchController.itemsResults!.length,
          itemBuilder: (context, index) {
            if (index < searchController.itemsResults!.length) {
              Item item = searchController.itemsResults![index];
              return ItemTile(item: item);
            }
          })
          : Padding(
          padding: EdgeInsets.only(bottom: 180.0.h),
          child: LottieBuilder.asset(
          "assets/anime/delivery.json",
          width: width,
          height: hieght / 2,
        ),
      ),
    );
  }
}