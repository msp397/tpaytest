import 'package:flutter/material.dart';
import 'package:tpay/screens/auth/createPin.dart';
import 'package:tpay/screens/others/dashboard.dart';

class SelectAuthPinType extends StatefulWidget {
  const SelectAuthPinType({super.key});

  @override
  State<SelectAuthPinType> createState() => _SelectAuthPinTypeState();
}

class _SelectAuthPinTypeState extends State<SelectAuthPinType> {
  int? _selectedOption = 1;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedOption = value;
    });
  }

  // Handle the submit action
  void _submit(BuildContext context) {
    if (_selectedOption == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const Dashboard()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CreatePin()));
    }
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Secure Google Pay',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Choose your preferred security method',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        ListTile(
                          leading: Radio<int>(
                            value: 1,
                            groupValue: _selectedOption,
                            onChanged: _handleRadioValueChange,
                          ),
                          title: const Text(
                            'Use your screen lock ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              'Protect Google Pay by using your nexisting phone screen lock or biometric',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          onTap: () {
                            _handleRadioValueChange(1);
                          },
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Radio<int>(
                            value: 2,
                            groupValue: _selectedOption,
                            onChanged: _handleRadioValueChange,
                          ),
                          title: const Text(
                            'Create Google PIN',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: const Text(
                              "Create a 4-digit Google PIN . You'll need to be connected to the internet to verify \nyour PIN",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          onTap: () {
                            // Handle the tap event if needed
                            _handleRadioValueChange(2);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                _submit(context);
              },
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
