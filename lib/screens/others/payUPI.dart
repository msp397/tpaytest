import 'package:flutter/material.dart';

class PayUPI extends StatefulWidget {
  const PayUPI({super.key});

  @override
  State<PayUPI> createState() => _PayUPIState();
}

class _PayUPIState extends State<PayUPI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter UPI ID or number',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Pay any',
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 5),
                          Image.network(
                            'https://arpitatulsyan.com/wp-content/uploads/2020/03/upi-logo-png-4.png',
                            width: 50,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'app using UPI ID or number',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextField(
                      controller: TextEditingController(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.zero,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
