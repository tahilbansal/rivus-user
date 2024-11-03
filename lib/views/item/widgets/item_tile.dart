import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:rivus_user/common/app_style.dart';
import 'package:rivus_user/common/reusable_text.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/controllers/item_controller.dart';
import 'package:rivus_user/models/items.dart';
import 'package:rivus_user/views/item/item_page.dart';
import 'package:rivus_user/controllers/counter_controller.dart';

class ItemTile extends StatelessWidget {
  final Item item;

  const ItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final CounterController counterController = Get.find<CounterController>();
    final ItemController itemController = Get.find<ItemController>();
    return GestureDetector(
      onTap: () {
        Get.to(() => ItemPage(item: item));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: 80,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kOffWhite,
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image or Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(item.imageUrl[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            // Title and Price
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: item.title,
                      style: appStyle(14, kDark, FontWeight.w500),
                    ),
                    SizedBox(height: 4.h),
                    ReusableText(
                      text: "\₹${item.price.toStringAsFixed(2)}",
                      style: appStyle(12, kPrimary, FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            // Quantity Controller
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('Increment');
                        counterController.increment(item);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: const Icon(
                          AntDesign.plussquareo,
                          color: kPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Obx(
                      () => ReusableText(
                          text: "${counterController.getItemCount(item.supplier, item.id)}",
                          style: appStyle(16, kDark, FontWeight.w500)),
                    ),
                    SizedBox(width: 6.w),
                    GestureDetector(
                      onTap: () {
                        counterController.decrement(item);
                      },
                      child: Container(
                        padding: EdgeInsets.all(
                            8.0), // Increased padding to make icon more tappable
                        child: const Icon(
                          AntDesign.minussquareo,
                          color: kPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          itemController.toggleFavoriteStatus(item);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            itemController.isFavorite(item)
                                ? AntDesign.heart
                                : AntDesign.hearto,
                            color: itemController.isFavorite(item)
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}