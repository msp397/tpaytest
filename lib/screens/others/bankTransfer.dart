import 'package:flutter/material.dart';

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
    bool isValidIFSC = ifscCode.length == 10;
    bool isValidAccountHolderName =
        accountHolderName.isNotEmpty && accountHolderName.length <= 15;

    bool formIsValid =
        isValidAccountNumber && isValidIFSC && isValidAccountHolderName;

    setState(() {
      isFormValid = formIsValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Column(
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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: accountNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bank Account Number',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: ifscCodeController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'IFSC Code',
                  suffix: TextButton(
                    onPressed: () {},
                    child: const Text('Search IFSC '),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColorDark,
                    ),
                  )),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: accountHolderController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Account Holder Name',
              ),
            ),
          ),
          const SizedBox(height: 20),
          // if (accountNumberController.text.isNotEmpty &&
          //     ifscCodeController.text.isNotEmpty &&
          //     accountHolderController.text.isNotEmpty)
          //   ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       foregroundColor: Colors.white,
          //       backgroundColor: isFormValid
          //           ? Theme.of(context).primaryColorLight
          //           : Theme.of(context).primaryColor,
          //     ),
          //     child: const Text('Proceed'),
          //   ),
        ],
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
                child: accountNumberController.text.isNotEmpty &&
                        ifscCodeController.text.isNotEmpty &&
                        accountHolderController.text.isNotEmpty
                    ? FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          print('Recharge button pressed');
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            'Procedd to Pay',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
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
        onTap: () {
          setState(() {
            moneyController.text =
                text.replaceAll('+ ', ''); // Extracting numeric value
          });
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MoneyTextField extends StatelessWidget {
  final TextEditingController controller;

  const MoneyTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          decoration: InputDecoration(
            prefixText: '₹ ',
            border: UnderlineInputBorder(borderSide: BorderSide.none),
          ),
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
