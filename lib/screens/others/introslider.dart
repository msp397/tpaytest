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
            titleWidget: const Padding(
              padding: EdgeInsets.all(40.0),
              child: Text(
                'Secure Payments \n       Pay now',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w300),
              ),
            ),
            bodyWidget: SizedBox(
              width: double.infinity,
              height: 500,
              child: Image.asset(
                'assets/images/png/intro_vector.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          PageViewModel(
            titleWidget: const Padding(
              padding: EdgeInsets.all(40.0),
              child: Text(
                'Verify Mobile number',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w300),
              ),
            ),
            bodyWidget: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Image.asset(
                      'assets/images/png/mobileNumber.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
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
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            selectorTextStyle:
                                const TextStyle(color: Colors.black),
                            initialValue: PhoneNumber(isoCode: 'IN'),
                            textFieldController: TextEditingController(),
                            formatInput: false,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: const OutlineInputBorder(),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Theme.of(context).primaryColor),
                                foregroundColor: WidgetStatePropertyAll(
                                    Theme.of(context).cardColor)),
                            onPressed: () {
                              // Action for the button
                            },
                            child: const Text("Send OTP"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            decoration: const PageDecoration(
              pageColor: Colors.white,
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
                  const TextField(
                    decoration: InputDecoration(
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
