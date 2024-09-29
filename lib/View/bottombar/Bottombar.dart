import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Call/Call_Page.dart';
import '../Profile/Profile_Page.dart';
import '../Status/Status.dart';
import '../home/home_page.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: [
            NavigationDestination(icon: Icon(Icons.chat), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Status'),
            NavigationDestination(icon: Icon(Icons.call), label: 'Call'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.Screen[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final Screen = [
    HomePage(),
    StatusScreen(),
    CallPage(),
    ProfilePage(),
  ];
}
