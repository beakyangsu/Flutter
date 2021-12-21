import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Disney+',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            flex:7,
            child: Stack(
              children: [
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    color: Color(0xFF040426),
                    image: DecorationImage(
                      image: AssetImage("assets/image/login.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xFF040426),
                          Colors.transparent,
                        ],
                        stops: [
                          0.0,
                          1.0
                        ]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Color(0xFF040426),
            ),
          ),
        ],
      ),
    );
  }
}