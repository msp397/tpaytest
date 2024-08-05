import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tpay/screens/auth/selectAuthPintype.dart';
import 'package:tpay/screens/others/dashboard.dart';

class Otpverification extends StatefulWidget {
  final String phonenumber;
  const Otpverification({super.key, required this.phonenumber});

  @override
  State<Otpverification> createState() => _OtpverificationState();
}

class _OtpverificationState extends State<Otpverification> with CodeAutoFill {
  final TextEditingController _otpController = TextEditingController();
  String? _code;
  Timer? _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    listenOtp();
    _startTimer();
  }

  void _startTimer() {
    _start = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _start--;
            });
          }
        });
      }
    });
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode();
    print('Otp Listen called');
  }

  @override
  void codeUpdated() {
    if (mounted) {
      setState(() {
        _code = code;
        if (_code != null && _code!.length == 6) {
          _submit(context);
        }
      });
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    _code = '';
    cancel();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_code!.length == 6) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => const SelectAuthPinType()),
      );
    }
  }

  void _resendOtp() {
    _startTimer();
    listenOtp();
  }

  @override
  Widget build(BuildContext context) {
    bool isResendEnabled = _start == 0;

    return Scaffold(
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
                      padding: const EdgeInsets.only(right: 100),
                      child: Image.asset(
                        'assets/images/png/torus_logo.png',
                        height: 90,
                        width: 90,
                      ),
                    ),
                    const Text(
                      'Verify your phone number',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter the OTP sent to ${widget.phonenumber}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    PinFieldAutoFill(
                      currentCode: _code,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      enabled: true,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onCodeChanged: (val) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              _code = val;
                            });
                          }
                        });
                        print("OTP changed: $val");
                      },
                      onCodeSubmitted: (val) {
                        _submit(context);
                      },
                      codeLength: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              // if (_code != null &&
              //     _code!.isNotEmpty &&
              //     _start > 0 &&
              //     _code!.length == 6)
              //   Padding(
              //     padding: const EdgeInsets.all(20),
              //     child: ElevatedButton(
              //       onPressed: () {
              //         _submit(context);
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shadowColor: Colors.transparent,
              //         backgroundColor: Theme.of(context).primaryColorDark,
              //         foregroundColor: Theme.of(context).primaryColorLight,
              //         padding: EdgeInsets.zero,
              //         minimumSize: const Size(double.infinity, 50),
              //       ),
              //       child: const Text('Verify'),
              //     ),
              //   ),
              if (!isResendEnabled)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_code!.length == 6) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SelectAuthPinType()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Theme.of(context).primaryColorDark,
                      foregroundColor: Theme.of(context).primaryColorLight,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(_code != null
                        ? _code!.length == 6
                            ? 'Verify'
                            : 'Resend in $_start seconds'
                        : 'Resend in $_start seconds'),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_code!.length == 6) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SelectAuthPinType()),
                        );
                      } else {
                        _resendOtp();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Theme.of(context).primaryColorDark,
                      foregroundColor: Theme.of(context).primaryColorLight,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(_code != null
                        ? _code!.length == 6
                            ? 'Verify'
                            : 'Resend'
                        : 'Resend'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
