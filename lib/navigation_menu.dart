import 'package:edtech/data/repositories/authentication/authentication_repositoris.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar_plus/persistent_bottom_nav_bar_plus.dart';

import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = KHelperFunctions.isDarkMode(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: PersistentTabView(
        context,
        controller: controller.persistentTabController,
        screens: controller.screens,
        items: _navBarsItems(),
        confineInSafeArea: false,
        backgroundColor: darkMode ? KColors.black : Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: darkMode ? KColors.black : Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popAllScreensOnTapAnyTabs: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style16,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.home),
        title: ("الرئيسي"),
        activeColorPrimary: KColors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.shop),
        title: ("الاقسام"),
        activeColorPrimary: KColors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.shopping_cart, color: KColors.white),
        title: ("عربة التسوق"),
        activeColorPrimary: KColors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.local_offer_outlined),
        title: ("العروض"),
        activeColorPrimary: KColors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.setting_2),
        title: ("الإعدادات"),
        activeColorPrimary: KColors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  static NavigationController get instance => Get.find();
  final PersistentTabController persistentTabController =
      PersistentTabController(initialIndex: 0);

  final List<Widget> screens = [
    home(),
    home(),
    home(),
    home(),
    home(),
  ];

  @override
  void onInit() {
    super.onInit();
    //checkForUpdate();
    persistentTabController.addListener(() {
      selectedIndex.value = persistentTabController.index;
      if (selectedIndex.value == 2) {
        // CartController.instance.updateCartPrices();
      }
    });
  }
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Home"),
              ElevatedButton(
                onPressed: () {
                  AuthenticationRepository.instance.logout();
                },
                child: const Text("برا يا كلب  "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
