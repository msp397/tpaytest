import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tpay/screens/auth/localAuth.dart';
import 'package:tpay/screens/others/dashboard.dart';

class Spalashscreen extends StatelessWidget {
  const Spalashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
      useImmersiveMode: true,
      gifPath: 'assets/images/gifs/tenor.gif',
      gifWidth: 269,
      gifHeight: 474,
      //backgroundColor: Theme.of(context).primaryColor,
      //nextScreen: const LocalAuthScreen(),
      nextScreen: Dashboard(),
      duration: const Duration(milliseconds: 5000),
    );
  }
}
