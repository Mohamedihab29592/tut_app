import 'package:flutter/material.dart';
import 'package:tut_app/presenation/main/pages/home/view/home_page.dart';
import 'package:tut_app/presenation/main/pages/notifications/notification_page.dart';
import 'package:tut_app/presenation/main/pages/search/view/search_page.dart';
import 'package:tut_app/presenation/main/pages/setting/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';
import '../resources/color_manger.dart';
import '../resources/routs_manager.dart';
import '../resources/strings_manger.dart';
import '../resources/values_manger.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  List<Widget> pages = [
     HomePage(),
    NotificationsPage(),
    SettingsPage()
  ];
  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];

  var _title = AppStrings.home.tr();
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: Theme.of(context).textTheme.titleSmall),
        actions:  [
         Padding(
           padding: const EdgeInsets.all(AppPadding.p8),
           child: IconButton(icon: const Icon(Icons.search),onPressed: (){
             Navigator.pushNamed(context, Routes.searchRoute);
           }, )
         ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items:  [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined), label: AppStrings.home.tr()),

            BottomNavigationBarItem(
                icon: const Icon(Icons.notifications),
                label: AppStrings.notifications.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings), label: AppStrings.settings.tr()),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}