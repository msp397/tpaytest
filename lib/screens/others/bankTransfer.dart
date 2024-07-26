import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Banktransfer extends StatefulWidget {
  const Banktransfer({super.key});

  @override
  State<Banktransfer> createState() => _BanktransferState();
}

class _BanktransferState extends State<Banktransfer> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController moneyController = TextEditingController();

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    moneyController.text == ""
        ? moneyController.text = '₹ 0'
        : moneyController.text;
    accountNumberController.addListener(validateForm);
    ifscCodeController.addListener(validateForm);
    accountHolderController.addListener(validateForm);
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    ifscCodeController.dispose();
    accountHolderController.dispose();
    moneyController.dispose();
    super.dispose();
  }

  void validateForm() {
    final String accountNumber = accountNumberController.text;
    final String ifscCode = ifscCodeController.text;
    final String accountHolderName = accountHolderController.text;

    bool isValidAccountNumber =
        accountNumber.length == 16 && int.tryParse(accountNumber) != null;
    bool isValidIFSC = ifscCode.length == 11;
    bool isValidAccountHolderName =
        accountHolderName.isNotEmpty && accountHolderName.length <= 20;

    bool formIsValid =
        isValidAccountNumber && isValidIFSC && isValidAccountHolderName;

    setState(() {
      isFormValid = formIsValid;
    });
  }

  void _updateMoney(double amount) {
    setState(() {
      final currentAmount =
          double.tryParse(moneyController.text.replaceAll('₹ ', '')) ?? 0.0;
      moneyController.text = '₹ ${currentAmount + amount}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MoneyTextField(
                    controller: moneyController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildRoundedBadge(100),
                        const SizedBox(width: 8),
                        _buildRoundedBadge(500),
                        const SizedBox(width: 8),
                        _buildRoundedBadge(1000),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: accountNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bank Account Number',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: ifscCodeController,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                    ],
                    maxLength: 11,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'IFSC Code',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColorDark,
                        backgroundColor: Theme.of(context).cardColor,
                        elevation: 0),
                    child: const Text('Search IFSC '),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: accountHolderController,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Account Holder Name',
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 150,
                height: 50,
                child: FloatingActionButton(
                  backgroundColor: isFormValid
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade200,
                  foregroundColor: isFormValid
                      ? Theme.of(context).primaryColorLight
                      : Colors.black,
                  onPressed: () {
                    print('proceed button pressed');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Proceed to Pay',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedBadge(double amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          _updateMoney(amount);
        },
        child: Text(
          '+ ${amount.toInt()}',
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}

class MoneyTextField extends StatelessWidget {
  final TextEditingController controller;

  const MoneyTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          decoration: const InputDecoration(
            prefixText: '',
            border: UnderlineInputBorder(borderSide: BorderSide.none),
          ),
          style: const TextStyle(
            fontSize: 50.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
