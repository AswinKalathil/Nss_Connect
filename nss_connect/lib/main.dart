import 'package:flutter/material.dart';
import 'package:nss_connect/register.dart';
import 'login.dart';
import 'cfmdta.dart';
import 'home.dart';
import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryViolet,
        fontFamily: 'Nexa',
      ),
      initialRoute: Home.id,
      routes: {
        Home.id: (ctx) => Home(),
        Login.id: (ctx) => Login(),
        Register.id: (ctx) => Register(),
        ConfirmData.id: (ctx) => ConfirmData(),
      },
      home: const Login(),
    );
  }
}
