import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pharma_go/AdminPanel/accountsAdminUI.dart';
import 'package:pharma_go/AdminPanel/chatAdminUI.dart';
import 'package:pharma_go/AdminPanel/orderAdminUI.dart';
import 'package:pharma_go/Home/homeUI.dart';
import 'package:pharma_go/Map/MapUI.dart';
import 'package:pharma_go/MedScan/medScanUI.dart';
import 'package:pharma_go/Profile/profileUI.dart';
import 'package:pharma_go/Shop/shopUI.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/my_flutter_app_icons.dart';
import 'package:provider/provider.dart';

import '../authentication/loginUI.dart';

class navigationBar extends StatefulWidget {
  const navigationBar({Key? key}) : super(key: key);

  @override
  State<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);


  var collection = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid);
  bool _isAdmin = false;

  Future<void> isAdmin() async {
    var docSnapshot = await collection.get();
    Map<String, dynamic>? data = docSnapshot.data();
    setState(() {
      _isAdmin = data!["isAdmin"];
    });
  }


  List<Widget> _userScreens() {
    return [
      const homeUI(),
      const shopUI(),
      const medScanUI(),
      const mapUI(),
      const profileUI()
    ];
  }

  List<Widget> _adminScreens() {
    return [
      const orderAdminUI(),
      const chatAdminUI(),
      const accountAdminUI(),
    ];
  }



  List<PersistentBottomNavBarItem> _userNavBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(MyFlutterApp.home),
        title: ("Home"),
        activeColorPrimary: const Color(0xff219C9C),
        inactiveColorPrimary: const Color(0xff7D7474),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MyFlutterApp.cart),
        title: ("Shop"),
        activeColorPrimary: const Color(0xff219C9C),
        inactiveColorPrimary: const Color(0xff7D7474),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MyFlutterApp.scan),
        title: ("Scan"),
        activeColorPrimary: const Color(0xff219C9C),
        inactiveColorPrimary: const Color(0xff7D7474),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MyFlutterApp.location),
        title: ("Map"),
        activeColorPrimary: const Color(0xff219C9C),
        inactiveColorPrimary: const Color(0xff7D7474),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MyFlutterApp.profile),
        title: ("Profile"),
        activeColorPrimary: const Color(0xff219C9C),
        inactiveColorPrimary: const Color(0xff7D7474),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _adminNavBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(MyFlutterApp.cart),
        title: ("Shop"),
        activeColorPrimary: const Color(0xff219C9C),
        inactiveColorPrimary: const Color(0xff7D7474),
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message_outlined),
        title: ("Chat"),
        activeColorPrimary: const Color(0xff219C9C),
        inactiveColorPrimary: const Color(0xff7D7474),
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(MyFlutterApp.profile),
        title: ("Profile"),
        activeColorPrimary: const Color(0xff219C9C),
        inactiveColorPrimary: const Color(0xff7D7474),
      ),
    ];
  }


  @override
  void initState() {
    isAdmin();
    print("loaded");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _isAdmin ? _adminScreens() : _userScreens(),
      items: _isAdmin ? _adminNavBarsItems() : _userNavBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows: false, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style13, // Choose the nav bar style with this property.
    );;
  }
}
