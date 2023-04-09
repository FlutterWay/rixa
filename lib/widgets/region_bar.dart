import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';

class RegionBar extends StatelessWidget {
  final void Function(int index) onChanged;
  final List<String> menuTexts;
  final Color? bgColor, selectedColor, labelColor, unselectedLabelColor;
  final TabController? controller;
  final TextStyle? labelStyle;
  RegionBar(
      {super.key,
      required this.onChanged,
      required this.menuTexts,
      Color? bgColor,
      this.controller,
      Color? labelColor,
      TextStyle? labelStyle,
      Color? unselectedLabelColor,
      Color? selectedColor})
      : bgColor = bgColor ?? Get.find<AppColors>().btnColor,
        selectedColor = selectedColor ?? Get.find<AppColors>().backgroundColor,
        labelColor = labelColor ?? Get.find<AppColors>().textColor,
        unselectedLabelColor =
            unselectedLabelColor ?? Get.find<AppColors>().hintColor,
        labelStyle = labelStyle ?? Get.find<AppFonts>().S();
  @override
  Widget build(BuildContext context) {
    double height = labelStyle!.fontSize! * 3;
    return Center(
      child: DefaultTabController(
        length: menuTexts.length,
        child: Container(
          height: height + 5,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            controller: controller,
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: height,
              indicatorColor: selectedColor!,
            ),
            labelStyle: labelStyle,
            labelColor: labelColor,
            unselectedLabelColor: unselectedLabelColor,
            tabs: <Widget>[
              for (int i = 0; i < menuTexts.length; i++) Text(menuTexts[i]),
            ],
            onTap: (index) {
              onChanged(index);
            },
          ),
        ),
      ),
    );
  }
}
