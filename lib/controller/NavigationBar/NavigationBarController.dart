import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationBarController extends GetxController {
  var pageIndex = 0.obs;




  Obx navigationBar() {
    return Obx(
      () => GlassBottomBar(
        items: [
          GlassBottomBarItem(
            icon: const Icon(MdiIcons.runFast, color: Color(0xFFDA1F05)),
            title: const GlassText("Interval"),
          ),
          GlassBottomBarItem(
            icon: const Icon(
              MdiIcons.dumbbell,
              color: Color(0xFF00CCFF),
            ),
            title: const GlassText("Gym"),
          ),
          GlassBottomBarItem(
            icon: const Icon(
              MdiIcons.bitcoin,
              color: Colors.amber,
            ),
            title: const GlassText("Donation app"),
          ),
        ],
        currentIndex: pageIndex.value,
        onTap: (i) {
          pageIndex.value = i;
        },
      ),
    );
  }
}
