import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sport_timer/viwes/GymScreen/GymScreen.dart';
import 'package:sport_timer/viwes/HomeScreen/IntervallScreen.dart';

import '../../controller/NavigationBar/NavigationBarController.dart';
import '../DonationScreen/DonationScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationBarController navigationBarController =
        Get.put(NavigationBarController());
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: navigationBarController.navigationBar(),
      body: SafeArea(
          child: Obx(
        () => IndexedStack(
          index: navigationBarController.pageIndex.value,
          children: [IntervallScreen(), GymScreen(), DonationScreen()],
        ),
      )),
    );
  }
}
