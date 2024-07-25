import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flower_store/screens/cart/cart.screen.dart';
import 'package:flower_store/screens/favorite.screen.dart';
import 'package:flower_store/screens/user/profile.screen.dart';
import 'package:flower_store/screens/store.main.screen.dart';
import 'package:flower_store/screens/store_product_page/all_product.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_store/screens/setting/setting.screen.dart';
import '../../shared/components/custom.theme.dart';

Widget? preScreen;

class MainPageScreen extends StatefulWidget {
  final Widget? currentScreen;
  final bool? isBack;
  const MainPageScreen({super.key, this.currentScreen, this.isBack});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  int _currentIndex = 0;
  bool isDarkMode = false;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      const StoreMainScreen(),
      const AllProductScreen(),
      const CartPage(),
      const FavoriteScreen(),
      SettingScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    ];
    if (widget.isBack != null && widget.isBack!) {
      _currentIndex =
          _pages.indexWhere((wg) => preScreen!.toString() == wg.toString());
    }
    if (widget.currentScreen != null) {
      _currentIndex = _pages.indexWhere(
          (wg) => widget.currentScreen!.toString() == wg.toString());
    }
    preScreen = _pages[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bottomNavBarTheme = theme.bottomNavigationBarTheme;

    final backgroundColor = bottomNavBarTheme.backgroundColor ??
        (isDarkMode ? const Color(0xffE5386D) : const Color(0xffF3DADF));
    final circleicon = const CircleAvatar().backgroundColor ??
        (isDarkMode
            ? const Color.fromARGB(255, 255, 255, 255)
            : const Color(0xffFF85A1));
    final selectedItemColor = bottomNavBarTheme.selectedItemColor ??
        (isDarkMode
            ? const Color(0xffE5386D)
            : const Color.fromARGB(255, 255, 255, 255));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        backgroundColor:
            isDarkMode ? const Color(0xff2D2C2C) : const Color(0xffEAEAEA),
        body: _pages[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          index: _currentIndex,
          height: 60.0,
          items: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundColor: circleicon,
              child: Icon(Icons.home, size: 25, color: selectedItemColor),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: circleicon,
              child: Icon(Icons.shop, size: 25, color: selectedItemColor),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: circleicon,
              child:
                  Icon(Icons.shopping_cart, size: 25, color: selectedItemColor),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: circleicon,
              child: Icon(Icons.favorite, size: 25, color: selectedItemColor),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: circleicon,
              child: Icon(Icons.settings, size: 25, color: selectedItemColor),
            ),
          ],
          color: backgroundColor,
          buttonBackgroundColor: circleicon,
          backgroundColor:
              isDarkMode ? const Color(0xff2D2C2C) : const Color(0xffF0F0F0),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              preScreen = _pages[_currentIndex];
              _currentIndex = index;
              if (index == 4) {
                _pages[4] = SettingScreen(
                  isDarkMode: isDarkMode,
                  onThemeChanged: (bool value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                );
              }
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
