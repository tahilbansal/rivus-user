import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rivus_user/common/app_style.dart';
import 'package:rivus_user/common/custom_container.dart';
import 'package:rivus_user/common/reusable_text.dart';
import 'package:rivus_user/common/shimmers/itemlist_shimmer.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/controllers/counter_controller.dart';
import 'package:rivus_user/hooks/fetchCart.dart';
import 'package:rivus_user/models/user_cart.dart';
import 'package:rivus_user/views/auth/widgets/login_redirect.dart';
import 'package:rivus_user/views/cart/widgets/cart_tile.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:rivus_user/views/cart/widgets/delivery_date_selector.dart';
import 'package:rivus_user/views/orders/checkout_page.dart';
import '../home/widgets/custom_btn.dart';
import 'package:intl/intl.dart';

class CartPage extends HookWidget {
  final String? supplierId;
  const CartPage({Key? key, this.supplierId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? token = box.read('token');

    final selectedDate = useState<DateTime?>(null);
    final hookResult = useFetchCart(supplierId: supplierId);
    final userCarts = hookResult.data;
    final isLoading = hookResult.isLoading;

    final CounterController counterController = Get.find<CounterController>();
    final controller = useTextEditingController();

    useEffect(() {
      if (!isLoading && hookResult.data != null) {
        counterController.calculateInitialCartTotal(hookResult.data!);
      }
      return null;
    }, [isLoading, hookResult.data]);

    void openDateSelector() async {
      final date = await showModalBottomSheet<DateTime>(
        context: context,
        isScrollControlled: true,
        builder: (context) => const DeliveryDateSelector(),
      );
      if (date != null) {
        selectedDate.value = date;
      }
    }

    return token == null
        ? const LoginRedirection()
        : Scaffold(
            backgroundColor: kOffWhite,
            appBar: AppBar(
              backgroundColor: kLightWhite,
              elevation: 0.3,
              title: Center(
                child: ReusableText(
                    text: "Your Cart", 
                    style: appStyle(18, kDark, FontWeight.bold)
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // handle delete all items
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: CustomContainer(
                containerContent: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isLoading
                    ? const ItemsListShimmer()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        width: width,
                        height: 0.7 * hieght,
                        color: kOffWhite,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: userCarts?.length ?? 0,
                          itemBuilder: (context, cartIndex) {
                            UserCart userCart = userCarts![cartIndex];
                            box.write("cart", userCarts.length.toString());
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: const EdgeInsets.all(8.0)),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: userCart.items.length,
                                  itemBuilder: (context, itemIndex) {
                                    var cartItem = userCart.items[itemIndex];
                                    return CartTile(
                                      cartItem: cartItem,
                                      // onDelete: () {
                                      //   hookResult.refetch();
                                      //   refreshNotifier.value++;
                                      // },
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    // Delivery Date Selector
                    Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: openDateSelector,
                          child: AbsorbPointer(
                            child: ValueListenableBuilder<DateTime?>(
                              valueListenable: selectedDate,
                              builder: (context, date, _) {
                                controller.text = date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
                                return TextFormField(
                                  readOnly: true,
                                  controller: controller,
                                  decoration: InputDecoration(
                                    labelText: "Delivery Date",
                                    hintText: "Select Delivery Date",
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                    //Checkout Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => ReusableText(
                            //text :  "₹${userCarts?.fold(0, (sum, cart) => sum + cart.grandTotal)?.toStringAsFixed(2) ?? '0.00'}",
                            text :  "₹${counterController.rxCartTotal.value.toStringAsFixed(2)}",
                            style: appStyle(18, kDark, FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CustomButton(
                              onTap: () {
                                List<CartItem> cartItems = [];
                                double grandTotal = 0;
                                if (userCarts != null) {
                                  for (var userCart in userCarts) {
                                    cartItems.addAll(userCart.items);
                                    grandTotal += userCart.grandTotal;
                                  }
                                }

                                if (selectedDate.value == null) {
                                  Get.snackbar(
                                    "Delivery Date Required",
                                    "Please select a delivery date before proceeding.",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: kSecondary,
                                    colorText: Colors.white,
                                  );
                                } else if (cartItems.isNotEmpty) {
                                  Get.to(() => CheckoutPage(
                                    cartItems: cartItems,
                                    supplierId: supplierId!,
                                    grandTotal: counterController.rxCartTotal.value,
                                    deliveryDate: selectedDate.value!,
                                  ));
                                } else {
                                  Get.snackbar(
                                    "Empty Cart",
                                    "No items available to checkout",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: kPrimary,
                                    colorText: Colors.white,
                                  );
                                }
                              },
                              radius: 10,
                              color: kPrimary,
                              btnWidth: double.infinity,
                              btnHieght: 48.h,
                              text: "Checkout",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}