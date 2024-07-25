//hide customLightTheme, customDarkTheme;
import 'package:flower_store/screens/mainpage/mainpage.screen.dart';
import 'package:flower_store/screens/store.main.screen.dart';
import 'package:flower_store/screens/welcome/login.screen.dart';
import 'package:flower_store/services/authorize.service.dart';
import 'package:flower_store/services/share_pre.dart';
import 'package:flower_store/shared/components/custom.theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  final SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
  static AuthorizeService authorizeService = AuthorizeService();
  Widget? w;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadLoginInfo();
  }
  @override
  Widget build(BuildContext context) {
    // _loadLoginInfo();
    return w != null ? getApp() : const SizedBox.shrink();
  }

  MaterialApp getApp() {
    return MaterialApp(
      routes: {
        '/login': (BuildContext context) => const LoginScreen()
      },
      builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: w);
  }

  Future<void> _loadLoginInfo() async {
    // Load user info from SharedPreferences
    String? prevAccount = await sharedPreferencesService.checkPrevSaveLogin();
    if (prevAccount != null) {
      authorizeService.getById(prevAccount)
      .then((value) => {
        debugPrint(value.toJson().toString()),
        sharedPreferencesService.saveAccountInfo(value)
        .then((val) => {
          setState(() {
            w = const MainPageScreen();
          })
        })
      });
    }
    else {
      setState(() {
        w = const LoginScreen();
      });
    }
  }
}
