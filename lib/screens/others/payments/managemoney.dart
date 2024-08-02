import 'package:flutter/material.dart';

class Managemoney extends StatefulWidget {
  const Managemoney({super.key});

  @override
  State<Managemoney> createState() => _ManagemoneyState();
}

class _ManagemoneyState extends State<Managemoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons
                .account_balance), // You can replace this with a custom icon if you prefer
            SizedBox(width: 8), // Add some space between the icon and the text
            Text('Bank Name'), // Replace 'Bank Name' with the actual bank name
          ],
        ),
      ),
    );
  }
}
