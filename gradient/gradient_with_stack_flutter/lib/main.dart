import 'package:disney_plus_clone_app/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disney+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'waltograph',
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0.0,
        ),
      ),
      home: loginPage(),
      // routes: {
      //       }
    );
  }
}
