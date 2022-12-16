import 'package:flutter/material.dart';
import 'package:github_mobile_app/pages/home/home.page.dart';
import 'package:github_mobile_app/pages/users/users.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/users',
      routes: {
        '/': (context) => HomePage(),
        '/users': (context) => UsersPage(),
      },
    );
  }
}

