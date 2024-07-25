import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpay/providers/themeProvider.dart';
import 'package:tpay/screens/others/dashboard.dart';
import 'package:tpay/screens/others/scanner.dart';
import 'package:tpay/screens/spalash/spalashScreen.dart';
import 'package:tpay/themes/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(lightTheme),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TPAY',
            theme: themeProvider.getTheme(),
            routes: {
              '/dashboard': (context) => Dashboard(),
            },
            home: const Spalashscreen(),
          );
        },
      ),
    );
  }
}
