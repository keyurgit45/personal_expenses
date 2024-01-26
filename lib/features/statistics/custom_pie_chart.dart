import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/controllers/statistics_controller.dart';
import 'package:personal_expenses/features/statistics/indicator.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import '../../controllers/theme_controller.dart';

class CustomPieChart extends StatelessWidget {
  CustomPieChart(this.categoryWiseList, {super.key});
  final Map<String, double> categoryWiseList;
  final StatisticsController statisticsController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AspectRatio(
      aspectRatio: 1,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        statisticsController.touchedIndex.value = -1;
                        return;
                      }
                      statisticsController.touchedIndex.value =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 130,
                  sections: showingSections(categoryWiseList),
                ),
              ),
            ),
            Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(categoryWiseList.length, (index) {
                  double total = 0;
                  final itr = categoryWiseList.entries
                      .map((e) => e.value)
                      .forEach((element) {
                    total += element;
                  });
                  return Indicator(
                    color: AppColors.pieChartColors.elementAt(index),
                    text:
                        "${categoryWiseList.entries.elementAt(index).key}   ${(categoryWiseList.entries.elementAt(index).value * 100 / total).toStringAsPrecision(2)}%",
                    isSquare: true,
                  );
                }).toList())
          ],
        ),
      ),
    ));
  }

  List<PieChartSectionData> showingSections(Map<String, double> categoryList) {
    return List.generate(categoryList.length, (i) {
      final isTouched = i == statisticsController.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        value: categoryList.entries.elementAt(i).value,
        color: AppColors.pieChartColors.elementAt(i),
        title: "${categoryList.entries.elementAt(i).value} Rs.",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          color: AppColors.chartBarBorderColorDark,
          shadows: shadows,
        ),
      );
    });
  }
}
