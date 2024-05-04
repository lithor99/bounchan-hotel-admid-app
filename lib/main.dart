import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/pages/auth/loginPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BCHAA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.danger),
        useMaterial3: true,
        primaryColor: ColorConstants.black,
        appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: ColorConstants.primary,
            titleTextStyle: getBoldStyle(
                fontSize: FontSizes.s16, color: ColorConstants.black)),
        backgroundColor: ColorConstants.black,
      ),
      home: LoginPage(),
    );
  }
}
