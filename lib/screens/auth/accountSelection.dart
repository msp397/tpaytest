import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tpay/account_service.dart';
import 'package:tpay/screens/auth/otpVerification.dart';

class AccountSelection extends StatefulWidget {
  final String phoneNumber;
  const AccountSelection({super.key, required this.phoneNumber});

  @override
  State<AccountSelection> createState() => _AccountSelectionState();
}

class _AccountSelectionState extends State<AccountSelection> {
  List<String> _googleAccounts = [];
  final AccountService _accountService = AccountService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _signInWithGoogle();
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Fetch user details
        final googleAuth = await googleUser.authentication;
        final String? accountName = googleUser.displayName;

        if (accountName != null) {
          setState(() {
            _googleAccounts = [accountName];
          });
        }
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  String _getAvatarText(String name) {
    if (name.isEmpty) {
      return '';
    }
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else {
      return name.substring(0, 2).toUpperCase();
    }
  }

  Widget _buildAvatar(String name) {
    return CircleAvatar(
      backgroundColor: Colors.blueAccent,
      radius: 24,
      child: Text(
        _getAvatarText(name),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> _submit(String account) async {
    var appSignatureID = await SmsAutoFill().getAppSignature;
    Map<String, String> sendOtpData = {
      "mobile_number": widget.phoneNumber,
      "app_signature_id": appSignatureID,
      "account": account
    };
    print(sendOtpData);

    // Navigate to Otpverification screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Otpverification(
          phonenumber: widget.phoneNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
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
                  'Choose your account',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This is how people on pay will see you',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: _googleAccounts.length,
                    itemBuilder: (context, index) {
                      final account = _googleAccounts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                          title: Text(account),
                          leading: _buildAvatar(account),
                          onTap: () => _submit(account),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        textAlign: TextAlign.justify,
                        text: const TextSpan(
                          text: 'By continuing you agree to the combined ',
                          style: TextStyle(fontSize: 11, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Google Pay Terms',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '\n    The Privacy Policy describes how your data is handled. \nGoogle Pay will periodically send your contacts and location \nto Google servers. People with your number can contact you \n access Google services and see your public information like \nname and photo. The phone number you have provided can \n                 be used on different Google Services',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_googleAccounts.isNotEmpty) {
                              _submit(_googleAccounts.first);
                            } else {
                              _submit('');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: Theme.of(context).primaryColorDark,
                            foregroundColor:
                                Theme.of(context).primaryColorLight,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Accept and continue'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
