import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tpay/screens/auth/chooseAccount.dart';

class Newregistration extends StatefulWidget {
  const Newregistration({super.key});

  @override
  State<Newregistration> createState() => _NewregistrationState();
}

class _NewregistrationState extends State<Newregistration> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  String _hintText = '00000 00000';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
  }

  void _onContinue() {
    if (_phoneController.text.isNotEmpty) {
      _phoneController.text = "";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChooseAccount(
            phoneNumber: phoneNumber,
          ),
        ),
      );
    }
  }

  String _getHintTextForCountry(String countryCode) {
    final Map<String, String> countryCodeToLength = {
      'IN': '00000 00000',
      'US': '(000) 000-0000',
    };

    return countryCodeToLength[countryCode] ?? '00000 00000';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard appears
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 300),
                      child: SizedBox(
                        height: 100,
                        width: 120,
                        child: Image.asset('assets/images/png/gpay_logo.png'),
                      ),
                    ),
                    const Text(
                      'Welcome to Pay',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your phone number',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 30),
                    IntlPhoneField(
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      autovalidateMode: AutovalidateMode.disabled,
                      style: const TextStyle(fontSize: 20),
                      // showCursor: false,
                      dropdownTextStyle: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        hintText: _hintText,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        setState(() {
                          phoneNumber = phone.completeNumber;
                        });
                      },
                      onSubmitted: (phone) {
                        _onContinue();
                      },
                      onCountryChanged: (country) {
                        setState(() {
                          _hintText = _getHintTextForCountry(country.code);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Image.asset(
              'assets/images/png/auth.jpg',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                _onContinue();
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
