import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rivus_user/common/shimmers/itemlist_shimmer.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/controllers/category_controller.dart';
import 'package:rivus_user/hooks/fetchCategory.dart';
import 'package:rivus_user/models/suppliers.dart';
import 'package:rivus_user/views/home/widgets/supplier_tile.dart';
import 'package:get/get.dart';

class CategorySupplierList extends HookWidget {
  const CategorySupplierList({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final hookResult =
        useFetchCategory(categoryController.categoryValue, "41007428");
    final suppliers = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;

    return isLoading
        ? const ItemsListShimmer()
        : Container(
            padding: EdgeInsets.only(left: 12.w, top: 10.h, right: 12.w),
            height: hieght,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: suppliers?.length ?? 0,
                itemBuilder: (context, index) {
                  Suppliers supplier = suppliers[index];
                  return SupplierTile(supplier: supplier);
                }),
          );
  }
}