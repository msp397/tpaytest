import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tpay/screens/others/dashboard.dart';

class Otpverification extends StatefulWidget {
  final String phonenumber;
  const Otpverification({super.key, required this.phonenumber});

  @override
  _OtpverificationState createState() => _OtpverificationState();
}

class _OtpverificationState extends State<Otpverification> with CodeAutoFill {
  final TextEditingController _otpController = TextEditingController();
  String? _code;

  @override
  void initState() {
    super.initState();
    listenOtp();
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode();
    print('Otp Listen called');
  }

  @override
  void codeUpdated() {
    setState(() {
      _code = code;
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    cancel();
    super.dispose();
  }

  void _submit() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(),
      ),
    );
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
                      onCodeChanged: (val) {
                        print("OTP changed: $val");
                      },
                      onCodeSubmitted: (val) {
                        _submit();
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
              if (_code != "")
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      _submit();
                      // if (code != null && code!.length == 6) {
                      //   _submit();
                      //   print("OTP entered: $code");
                      // } else {
                      //   print("Invalid OTP code");
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Theme.of(context).primaryColorDark,
                      foregroundColor: Theme.of(context).primaryColorLight,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Verify'),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    listenOtp();
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Theme.of(context).primaryColorDark,
                    foregroundColor: Theme.of(context).primaryColorLight,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Resend'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
