import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MyIntroSlider extends StatelessWidget {
  const MyIntroSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Test",
            body: "This is the test page.",
            decoration: const PageDecoration(
              pageColor: Colors.blue,
              bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
            ),
            footer: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "This is the bottom text for the Test slide.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          PageViewModel(
            title: "Phone OTP",
            body: "Enter your phone number to receive an OTP.",
            decoration: const PageDecoration(
              pageColor: Colors.white,
            ),
            footer: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InternationalPhoneNumberInput(
                    onInputChanged: (phoneNumber) {
                      print(phoneNumber.phoneNumber);
                    },
                    onInputValidated: (bool value) {
                      print(value);
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: PhoneNumber(isoCode: 'IN'),
                    textFieldController: TextEditingController(),
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: const OutlineInputBorder(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Action for the button
                    },
                    child: const Text("Send OTP"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          PageViewModel(
            title: "OTP Verify",
            body: "Verify the OTP received on your phone.",
            decoration: const PageDecoration(
              pageColor: Colors.blue,
              bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
            ),
            footer: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'OTP',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Action for the button
                    },
                    child: const Text("OTP Verify"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
        onDone: () {},
        onSkip: () {},
        showSkipButton: true,
        skip: const Text("Skip"),
        next: const Text("Next"),
        done: const Text("Done"),
      ),
    );
  }
}
