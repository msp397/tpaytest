import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tpay/providers/dependemcyInjection.dart';
import 'package:tpay/providers/themeProvider.dart';
import 'package:tpay/screens/others/dashboard.dart';
import 'package:tpay/screens/spalash/spalashScreen.dart';
import 'package:tpay/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Torus Pay',
          theme: themeProvider.getTheme(),
          routes: {
            '/dashboard': (context) => const Dashboard(),
          },
          home: const Spalashscreen(),
        );
      },
    );
  }
}
