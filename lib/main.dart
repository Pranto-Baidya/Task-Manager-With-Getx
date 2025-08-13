

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:untitled3/controller_binder.dart';
import 'package:untitled3/ui/screens/main_bottom_nav_screen.dart';
import 'package:untitled3/ui/screens/splash_screen.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';


main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  runApp(MyApp());
}



class MyApp extends StatefulWidget{
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: MyApp.navigatorKey,
      theme: ThemeData(

        iconTheme: IconThemeData(
          color: Colors.green
        ),
        textTheme: TextTheme(),
        colorSchemeSeed: AppColors.themeColor,
        inputDecorationTheme: _buildInputDecorationTheme(),
        elevatedButtonTheme: _buildElevatedButtonThemeData()
      ),
      debugShowCheckedModeBanner: false,
      home: splash(),
      initialBinding: controllerBinder(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=> splash(),transition: Transition.leftToRight),
        GetPage(name: '/home', page: ()=> mainBottomNavScreen(),transition: Transition.leftToRight),

      ],
      /*routes: {
        splash.name : (context) => splash(),
        mainBottomNavScreen.name : (context) => mainBottomNavScreen()
      },*/
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF003366),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minimumSize: Size(double.infinity, 55),
            elevation: 3
        ),
      );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: _buildOutlineInputBorder(),
        focusedBorder: _buildOutlineInputBorder(),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red
          )
        )
      );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFF003366)
          ),
        );
  }
}