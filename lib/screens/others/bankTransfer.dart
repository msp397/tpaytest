import 'package:flutter/material.dart';

class Banktransfer extends StatefulWidget {
  const Banktransfer({super.key});

  @override
  State<Banktransfer> createState() => _BanktransferState();
}

class _BanktransferState extends State<Banktransfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color.fromARGB(255, 97, 184, 255),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(),
      ),
    );
  }
}
