import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Welcome to Flutter'),
            ),
            body: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.red,
                      Colors.orange[700],
                      Colors.blue
                    ]), //背景渐变
                    borderRadius: BorderRadius.circular(3.0), //3像素圆角
                    boxShadow: [
                      //阴影
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0),
                      BoxShadow(
                          color: Colors.blue,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0)
                    ]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ))));
  }
}