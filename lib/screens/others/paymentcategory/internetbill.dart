import 'package:flutter/material.dart';

class Internetbill extends StatefulWidget {
  const Internetbill({super.key});

  @override
  State<Internetbill> createState() => _InternetbillState();
}

class _InternetbillState extends State<Internetbill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Internet Bill"),
      ),
      body: Text("Internet Bill"),
    );
  }
}
