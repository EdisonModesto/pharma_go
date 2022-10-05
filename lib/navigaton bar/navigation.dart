import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pharma_go/Home/homeUI.dart';
import 'package:pharma_go/Map/MapUI.dart';
import 'package:pharma_go/MedScan/medScanUI.dart';
import 'package:pharma_go/Shop/shopUI.dart';
import 'package:pharma_go/my_flutter_app_icons.dart';

import '../authentication/loginUI.dart';

class navigationBar extends StatefulWidget {
  const navigationBar({Key? key}) : super(key: key);

  @override
  State<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  void checkAuth(){
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const loginUI()));
      } else {
        print('User is signed in!');
      }
    });
  }



  List<Widget> _buildScreens() {
    return [
      homeUI(),
      shopUI(),
      medScanUI(),
      mapUI(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.home),
        title: ("Home"),
        activeColorPrimary: Color(0xff219C9C),
        inactiveColorPrimary: Color(0xff7D7474),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.cart),
        title: ("Shop"),
        activeColorPrimary: Color(0xff219C9C),
        inactiveColorPrimary: Color(0xff7D7474),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.scan),
        title: ("Shop"),
        activeColorPrimary: Color(0xff219C9C),
        inactiveColorPrimary: Color(0xff7D7474),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(MyFlutterApp.location),
        title: ("Map"),
        activeColorPrimary: Color(0xff219C9C),
        inactiveColorPrimary: Color(0xff7D7474),
      ),
    ];
  }

  @override
  void initState() {
    checkAuth();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style13, // Choose the nav bar style with this property.
    );;
  }
}
