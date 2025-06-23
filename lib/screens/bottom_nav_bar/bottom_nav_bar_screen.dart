import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/screens/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:sizer/sizer.dart';


class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});
  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int index = 0;
  late final PersistentTabController _controller;

  final List<BottomTabModel> _bottomTabs = [
    BottomTabModel(icon: const Icon(Icons.home), view: HomeScreen()),
    BottomTabModel(icon: const Icon(Icons.bar_chart), view: Container()),
    BottomTabModel(icon: const Icon(Icons.emoji_events), view: Container()),
    BottomTabModel(icon: const Icon(Icons.settings), view: Container()),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: index);
  }

  @override
  Widget build(BuildContext context) => SafeArea(child: Scaffold(body: _persistentTabBar()));

  PersistentBottomNavBarItem _navItem(IconData icon, String title) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      title: title,
      activeColorPrimary: AppColors.buttonColor,
      activeColorSecondary:  AppColors.buttonColor,
      inactiveColorPrimary: AppColors.whiteColor,
      contentPadding: 0,
      textStyle:  TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,

      ),
    );
  }

  Widget _persistentTabBar() {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _bottomTabs.map((e) => e.view).toList(),
      navBarStyle: NavBarStyle.style6,
      navBarHeight: 60,
      backgroundColor: AppColors.darkBrandColor,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: NavBarDecoration(
        colorBehindNavBar: AppColors.whiteColor,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        // border: Border.all(color: AppColors.borderTextFieldColor, width: 2),
      ),
      items: [
        _navItem(Icons.home, 'Home'),
        _navItem(Icons.bar_chart, 'Portfolio'),
        _navItem(Icons.emoji_events, 'Top'),
        _navItem(Icons.settings, 'Settings'),
      ],
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(duration: Duration(milliseconds: 400), curve: Curves.ease),
      ),
      onItemSelected: (value) => setState(() => index = value),
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
    );
  }
}


class BottomTabModel {
  Widget icon;
  Widget view;

  BottomTabModel({required this.icon, required this.view});
}
