import 'dart:math';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tpay/screens/auth/accountSelection.dart';

class Newregistration extends StatefulWidget {
  const Newregistration({super.key});

  @override
  State<Newregistration> createState() => _NewregistrationState();
}

class _NewregistrationState extends State<Newregistration> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  String _hintText = '00000 00000';
  String _selectedCountryCode = 'IN';
  final bool _isAutofilled = false;

  @override
  void initState() {
    super.initState();
    _hintText = _getHintTextForCountry(_selectedCountryCode);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  String _getHintTextForCountry(String countryCode) {
    final Map<String, String> countryCodeToHintText = {
      'IN': '00000 00000',
      'US': '(000) 000-0000',
      'AE': '000 0000 0000',
    };
    return countryCodeToHintText[countryCode] ?? '00000 00000';
  }

  int _getPhoneNumberLengthForCountry(String countryCode) {
    final Map<String, int> countryCodeToLength = {
      'IN': 10,
      'US': 10,
      'AE': 9,
    };
    return countryCodeToLength[countryCode] ?? 10;
  }

  bool _isPhoneNumberValid(String phoneNumber, String countryCode) {
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    String localNumber;
    if (countryCode == 'IN') {
      localNumber = cleanedNumber.replaceFirst(RegExp(r'^91'), '');
    } else if (countryCode == 'US') {
      localNumber = cleanedNumber;
    } else {
      localNumber = cleanedNumber;
    }

    final length = _getPhoneNumberLengthForCountry(countryCode);
    setState(() {});
    return localNumber.length == length;
  }

  void _onContinue() {
    final phoneNumber = _phoneController.text;
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanedNumber.isNotEmpty &&
        _isPhoneNumberValid(cleanedNumber, _selectedCountryCode)) {
      if (_isAutofilled) {
        print("Phone number was auto-filled.");
      } else {
        print("Phone number was manually entered.");
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountSelection(
            phoneNumber: cleanedNumber,
          ),
        ),
      );
      _phoneController.text = "";
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid phone number.'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    Image.asset(
                      'assets/icons/torus.ico',
                      height: 90,
                      width: 90,
                    ),
                    Text('Welcome to Torus Pay',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your phone number',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: _phoneController,
                      countryCode: _selectedCountryCode,
                      decoration: InputDecoration(
                        hintText: _hintText,
                        hintStyle: const TextStyle(fontSize: 20),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButton<String>(
                            value: _selectedCountryCode,
                            focusColor: Colors.white,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedCountryCode = newValue;
                                  _hintText = _getHintTextForCountry(newValue);
                                });
                              }
                            },
                            items: <String>['IN', 'US', 'AE']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    CountryFlag.fromCountryCode(
                                      value,
                                      height: 20,
                                      width: 30,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      onSubmitted: (val) {
                        _onContinue();
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/png/deposit.jpg',
              width: double.infinity,
              height: 200,
              cacheHeight: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: _onContinue,
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

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String countryCode;
  final InputDecoration decoration;
  final Function(String) onSubmitted;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.countryCode,
    required this.decoration,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneFieldHint(
      controller: controller,
      inputFormatters: <TextInputFormatter>[
        PhoneNumberFormatter(countryCode),
      ],
      decoration: decoration,
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  final String countryCode;

  PhoneNumberFormatter(this.countryCode);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final phoneNumber = newValue.text.replaceAll(RegExp(r'\D'), '');

    String formattedNumber;
    switch (countryCode) {
      case 'IN':
        formattedNumber = phoneNumber.length <= 5
            ? phoneNumber
            : '${phoneNumber.substring(0, 5)} ${phoneNumber.substring(5, min(phoneNumber.length, 10))}';
        break;
      case 'US':
        formattedNumber = phoneNumber.length <= 3
            ? '($phoneNumber'
            : phoneNumber.length <= 6
                ? '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3)}'
                : phoneNumber.length <= 10
                    ? '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}'
                    : '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 10)}';
        break;
      case 'AE':
        formattedNumber = phoneNumber.length <= 4
            ? phoneNumber
            : phoneNumber.length <= 9
                ? '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, min(phoneNumber.length, 9))}'
                : '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 9)}';
        break;
      default:
        formattedNumber = phoneNumber;
        break;
    }

    return newValue.copyWith(
      text: formattedNumber,
      selection: TextSelection.collapsed(offset: formattedNumber.length),
    );
  }
}
