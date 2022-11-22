import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'total_of_transactions.dart';
import 'transaction_list/transaction_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/home_page_controller.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';
import '../themes/app_colors.dart';

class MyHomePage extends StatelessWidget {
  final HomePageController homePageController = Get.put(HomePageController());
  final ThemeController themeController = Get.find();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
      backgroundColor: themeController.isDarkMode.value
                        ? AppColors.appBarBackgroundColorDark
                        : AppColors.appBarBackgroundColorLight,
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.11,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: AppColors.appBarFillColor,
        ),
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.055,
          bottom: MediaQuery.of(context).size.height * 0.015,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Row(
          children: [
            Builder(builder: ((context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: (() => Scaffold.of(context).openDrawer()),
                  icon: Icon(
                    Icons.menu_rounded,
                    color: themeController.isDarkMode.value
                        ? AppColors.appBarIconColorDark
                        : AppColors.appBarIconColorLight,
                  ),
                ),
              );
            })),
            Expanded(
              child: Text(
                'Personal Expenses',
                style: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.titleTextColorDark
                      : AppColors.titleTextColorLight,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
                onPressed: (() {
                  themeController.isDarkMode.value =
                      !themeController.isDarkMode.value;
                  themeController.changeTheme();
                }),
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, anim) => RotationTransition(
                    turns: child.key == const ValueKey('icon1')
                        ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                        : Tween<double>(begin: 0.75, end: 1).animate(anim),
                    child: ScaleTransition(scale: anim, child: child),
                  ),
                  child: themeController.isDarkMode.value
                      ? Icon(
                          Icons.sunny,
                          key: const ValueKey('icon1'),
                          color: AppColors.appBarIconColorDark,
                        )
                      : Icon(
                          CupertinoIcons.moon_stars_fill,
                          key: const ValueKey('icon2'),
                          color: AppColors.appBarIconColorLight,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
      drawer: NavigationDrawer(),
      body: Obx(
        (() => SingleChildScrollView(
              child: Column(
                      children: <Widget>[
                        TotalOfTransactions(
                            homePageController.groupedTransactionValuesMonthly),
                        TransactionList(),
                      ],
                    ),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 45,
        width: 150,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          onPressed: (() {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    homePageController.startAddNewTransaction(context));
          }),
          child: const Text(
            "+ Add Transaction",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
