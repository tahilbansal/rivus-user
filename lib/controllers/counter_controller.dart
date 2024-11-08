import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rivus_user/controllers/cart_controller.dart';
import 'package:rivus_user/models/cart_request.dart';
import 'package:rivus_user/models/items.dart';
import 'package:rivus_user/models/user_cart.dart';

class CounterController extends GetxController {
  final box = GetStorage();
  final CartController cartController = Get.put(CartController());
  final RxMap<String, RxMap<String, RxInt>> supplierItemCounts = <String, RxMap<String, RxInt>>{}.obs;
  final RxDouble rxCartTotal = 0.0.obs;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    // Load the stored supplierItemCounts from local storage when the controller initializes
    Map<String, dynamic> storedCounts = box.read('supplierItemCounts') ?? {};
    supplierItemCounts.assignAll(storedCounts.map((supplierId, items) {
      RxMap<String, RxInt> rxItemMap = RxMap<String, RxInt>();
      (items as Map).forEach((itemId, count) {
        rxItemMap[itemId] = RxInt(count);
      });
      return MapEntry(supplierId, rxItemMap);
    }));

    // double cartTotal = box.read('cartTotal') ?? 0.0;
    // rxCartTotal.value = cartTotal;
  }

  void increment(Item item) {
    String supplierId = item.supplier;
    String itemId = item.id;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      supplierItemCounts[supplierId] ??= <String, RxInt>{}.obs;
      supplierItemCounts[supplierId]![itemId] ??= RxInt(0);
      supplierItemCounts[supplierId]![itemId]!.value++;
      rxCartTotal.value += item.price;
      _saveItemCountsAndTotalToLocalStorage();
      updateCart(item);
    });
  }

  void decrement(Item item) {
    String supplierId = item.supplier;
    String itemId = item.id;
    if (supplierItemCounts[supplierId] != null &&
        supplierItemCounts[supplierId]![itemId] != null &&
        supplierItemCounts[supplierId]![itemId]!.value > 0) {

      if (_debounce?.isActive ?? false) _debounce?.cancel();

      _debounce = Timer(const Duration(milliseconds: 100), () {
        supplierItemCounts[supplierId]![itemId]!.value--;

        if (supplierItemCounts[supplierId]![itemId]!.value >= 0) {
          rxCartTotal.value -= item.price;
        }

        if (supplierItemCounts[supplierId]![itemId]!.value < 1) {
          cartController.removeFormCart(supplierId, item.id);
        } else {
          cartController.decrementFromCart(item.id);
        }
        _saveItemCountsAndTotalToLocalStorage();

      });
    }
  }

  void updateCart(Item item) {
    String supplierId = item.supplier;
    String itemId = item.id;
    int count = supplierItemCounts[supplierId]?[itemId]?.value ?? 0;

    ToCart cartItem = ToCart(
      productId: itemId,
      supplierId: supplierId,
      instructions: "",
      additives: [],
      quantity: count,
      totalPrice: 0,
    );

    if (count == 0) {
      cartController.removeFormCart(supplierId, itemId);
    } else {
      cartController.addToCart(toCartToJson(cartItem));
    }
  }

  void _saveItemCountsAndTotalToLocalStorage() {
    // Save the entire supplierItemCounts map to local storage
    Map<String, Map<String, int>> simpleMap =
        supplierItemCounts.map((supplierId, items) {
      return MapEntry(supplierId, items.map((itemId, count) => MapEntry(itemId, count.value)));
    });
    box.write('supplierItemCounts', simpleMap);
    box.write('cartTotal', rxCartTotal.value);
  }

  int getItemCount(String supplierId, String itemId) {
    return supplierItemCounts[supplierId]?[itemId]?.value ?? 0;
  }

  int getSupplierItemCount(String supplierId) {
    if (supplierItemCounts.containsKey(supplierId)) {
      return supplierItemCounts[supplierId]!.values.fold(0, (sum, count) => sum + count.value);
    }
    return 0;
  }

  void resetItemCount(String supplierId, String itemId) {
    supplierItemCounts[supplierId]?[itemId]?.value = 0;
  }

  void calculateInitialCartTotal(List<UserCart> userCarts) {
    double total = 0;
    for (var userCart in userCarts) {
      total += userCart.grandTotal;
    }
    rxCartTotal.value = total;
  }

  void updateCartTotal(double amount) {
    rxCartTotal.value += amount;
  }

}
