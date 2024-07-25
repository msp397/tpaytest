import 'package:flutter/material.dart';
import 'package:tpay/screens/others/dashboard.dart';
import 'package:tpay/screens/others/scanner.dart';
import 'package:tpay/screens/spalash/spalashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TPAY',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/dashboard': (context) => Dashboard(),
          '/scanner': (context) => MyScanner(),
        },
        home: const Spalashscreen(),
      ),
    );
  }
}
