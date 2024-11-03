import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rivus_user/common/app_style.dart';
import 'package:rivus_user/common/reusable_text.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/models/order_details.dart';

class OrderPageTile extends StatelessWidget {
  const OrderPageTile({
    super.key,
    required this.item,
    required this.status,
  });

  final OrderItem item;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8.h, right: 8.w, left: 8.w),
          height: 80,
          width: width,
          decoration: const BoxDecoration(
              color: kLightWhite,
              borderRadius: BorderRadius.all(Radius.circular(9))),
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Stack(
                    children: [
                      SizedBox(
                          height: 75.h,
                          width: 80.h,
                          child: Image.network(
                            item.itemId.imageUrl[0],
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.only(left: 6, bottom: 2),
                            color: kGray.withOpacity(0.6),
                            height: 16,
                            width: width,
                            // child: RatingBarIndicator(
                            //   rating: 5,
                            //   itemBuilder: (context, index) => const Icon(
                            //     Icons.star,
                            //     color: Colors.amber,
                            //   ),
                            //   itemCount: 5,
                            //   itemSize: 15.0,
                            //   direction: Axis.horizontal,
                            // ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableText(
                        text: item.itemId.title,
                        style: appStyle(11, kDark, FontWeight.w500)),
                    ReusableText(
                        text: "Quanitty: ${item.quantity}",
                        style: appStyle(9, kGray, FontWeight.w500)),
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableText(
                        text: "Price: ${item.price}",
                        style: appStyle(9, kGray, FontWeight.w500))
                    // SizedBox(
                    //   height: 18,
                    //   width: width * 0.67,
                    //   child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: item.additives.length,
                    //       itemBuilder: (context, i) {
                    //         final addittives = item.additives[i];
                    //         return Container(
                    //           margin: const EdgeInsets.only(right: 5),
                    //           decoration: const BoxDecoration(
                    //               color: kSecondaryLight,
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(9))),
                    //           child: Center(
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(2.0),
                    //               child: ReusableText(
                    //                   text: addittives,
                    //                   style:
                    //                       appStyle(8, kGray, FontWeight.w400)),
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 18.h,
            decoration: const BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Center(
              child: ReusableText(
                  text: status,
                  style: appStyle(10, kLightWhite, FontWeight.w600)),
            ),
          ),
        )
      ],
    );
  }
}
