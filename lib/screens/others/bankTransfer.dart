import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tpay/widgets/autocomplete.dart';
import 'package:tpay/widgets/button.dart';
import 'package:tpay/widgets/textField.dart';

class Banktransfer extends StatefulWidget {
  const Banktransfer({super.key});

  @override
  State<Banktransfer> createState() => _BanktransferState();
}

class _BanktransferState extends State<Banktransfer> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              // borderRadius: const BorderRadius.only(
              //   bottomLeft: Radius.circular(10),
              //   bottomRight: Radius.circular(10),
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MoneyTextField(
                  controller: controller,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRoundedBadge('+ 100'),
                    const SizedBox(width: 8),
                    _buildRoundedBadge('+ 500'),
                    const SizedBox(width: 8),
                    _buildRoundedBadge('+ 1000'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Account Namber
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  'Bank Account Number',
                ),
              ),
            ),
          )
          // IFSC Code

          // Proceed
        ],
      ),
    );
  }

  Widget _buildRoundedBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          setState(() {
            controller.text = text;
          });
        },
      ),
    );
  }
}
