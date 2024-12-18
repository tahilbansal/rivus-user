import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:rivus_user/common/app_style.dart';
import 'package:rivus_user/common/reusable_text.dart';
import 'package:rivus_user/constants/constants.dart';
import 'package:rivus_user/controllers/tab_controller.dart';
import 'package:rivus_user/hooks/fetchDefaultAddress.dart';
import 'package:rivus_user/views/cart/cart_page.dart';
import 'package:rivus_user/views/home/home_page.dart';
import 'package:rivus_user/views/message/view.dart';
import 'package:rivus_user/views/profile/profile_page.dart';
import 'package:rivus_user/views/search/seach_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'orders/client_orders.dart';

// ignore: must_be_immutable
class MainScreen extends HookWidget {
  MainScreen({Key? key}) : super(key: key);

  final box = GetStorage();

  List<Widget> pageList = <Widget>[
    const HomePage(),
    const MessagePage(),
    const ClientOrderPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? token = box.read('token');
    bool? verification = box.read("verification");
    if (token != null && verification == false) {
    } else if (token != null && verification == true) {
      useFetchDefault(context, true);
    }
    final entryController = Get.put(MainScreenController());

    // Use the argument to set tabIndex and control loading
    final args = Get.arguments;
    if (args != null && args == 1) {
      Future.delayed(Duration(milliseconds: 50), () {
        entryController.setTabIndex = 1;
      });
    }
    return Obx(() => Scaffold(
          body: Stack(
            children: [
              pageList[entryController.tabIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: kPrimary),
                  child: BottomNavigationBar(
                      selectedFontSize: 12,
                      backgroundColor: kPrimary,
                      elevation: 0,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      unselectedIconTheme: const IconThemeData(color: Colors.black38),
                      items: [
                        BottomNavigationBarItem(
                          icon: entryController.tabIndex == 0
                              ? const Icon(
                                  AntDesign.appstore1,
                                  color: kSecondary,
                                  size: 24,
                                )
                              : const Icon(AntDesign.appstore1),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: entryController.tabIndex == 1
                              ? const Icon(
                                  Ionicons.chatbubble_ellipses,
                                  color: kSecondary,
                                  size: 28,
                                )
                              : const Icon(Ionicons.chatbubble_ellipses),
                          label: 'Inbox',
                        ),
                        BottomNavigationBarItem(
                          icon: entryController.tabIndex == 2
                              ? Badge(
                                  label: ReusableText(
                                      text: box.read('cart') ?? "0",
                                      style: appStyle(8, kLightWhite, FontWeight.normal)),
                                  child: const Icon(
                                    FontAwesome.truck,
                                    color: kSecondary,
                                    size: 24,
                                  ))
                              : Badge(
                                  label: ReusableText(
                                      text: box.read('cart') ?? "0",
                                      style: appStyle(8, kLightWhite, FontWeight.normal)),
                                  child: const Icon(FontAwesome.truck,),
                                ),
                          label: 'Orders',
                        ),
                        BottomNavigationBarItem(
                          icon: entryController.tabIndex == 3
                              ? const Icon(
                                  FontAwesome.user_circle_o,
                                  color: kSecondary,
                                  size: 24,
                                )
                              : const Icon(
                                  FontAwesome.user_circle_o,
                                ),
                          label: 'Profile',
                        ),
                      ],
                      currentIndex: entryController.tabIndex,
                      unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                      selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                      onTap: ((value) {
                        entryController.setTabIndex = value;
                      })),
                ),
              ),
            ],
          ),
        ));
  }
}
