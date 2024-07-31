import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tpay/screens/auth/accountSelection.dart';
import 'package:tpay/screens/others/paymentcategory/electricitybill.dart';

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
  String _selectedCountryCode = 'IN';

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
          builder: (context) => AccountSelection(
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          DropdownButton<String>(
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
            items: <String>['IN', 'US']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    CountryFlag.fromCountryCode(
                      value,
                      height: 20,
                      width: 25,
                    ),
                    const SizedBox(width: 10),
                    Text(value),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
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
                      'assets/images/png/gpay_logo.png',
                      height: 90,
                      width: 70,
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
                    // IntlPhoneField(
                    //   controller: _phoneController,
                    //   focusNode: _phoneFocusNode,
                    //   autovalidateMode: AutovalidateMode.disabled,
                    //   style: const TextStyle(fontSize: 20),
                    //   // showCursor: false,
                    //   dropdownTextStyle: TextStyle(fontSize: 20),
                    //   decoration: InputDecoration(
                    //     hintText: _hintText,
                    //     border: const OutlineInputBorder(
                    //       borderSide: BorderSide(),
                    //     ),
                    //   ),
                    //   initialCountryCode: 'IN',
                    //   onChanged: (phone) {
                    //     setState(() {
                    //       phoneNumber = phone.completeNumber;
                    //     });
                    //   },
                    //   onSubmitted: (phone) {
                    //     _onContinue();
                    //   },
                    //   onCountryChanged: (country) {
                    //     setState(() {
                    //       _hintText = _getHintTextForCountry(country.code);
                    //     });
                    //   },
                    // ),
                    PhoneFieldHint(
                      controller: _phoneController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                        hintText: _hintText,
                        hintStyle: const TextStyle(fontSize: 20),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
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
              'assets/images/png/auth.jpg',
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
