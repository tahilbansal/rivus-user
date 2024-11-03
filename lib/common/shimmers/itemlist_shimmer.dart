import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rivus_user/common/shimmers/shimmer_widget.dart';
import 'package:rivus_user/constants/constants.dart';

class ItemsListShimmer extends StatelessWidget {
  const ItemsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 10),
      height: hieght,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          itemCount: 6,
          itemBuilder: (context, index) {
            return ShimmerWidget(
                shimmerWidth: width, shimmerHieght: 70.h, shimmerRadius: 12);
          }),
    );
  }
}