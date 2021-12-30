import 'package:Youtube_flutter/screens/channel_screen.dart';
import 'package:Youtube_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';




void main() {
  runApp(
    HomeApp(),
  );
}

class HomeApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Youtube Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );

  }


}