import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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

  @override
  void initState() {
    super.initState();
    _loadGoogleAccounts();
  }

  Future<void> _loadGoogleAccounts() async {
    //var permissionStatus = await Permission.contacts.request();
    try {
      List<String> accounts = await _accountService.getGoogleAccounts();
      setState(() {
        _googleAccounts = accounts;
      });
    } catch (e) {
      print('Error fetching Google accounts: $e');
    }
    // if (permissionStatus.isGranted) {

    // } else {
    //   print('Permission denied to access contacts.');
    // }
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

  void _submit(String account) async {
    var appSignatureID = await SmsAutoFill().getAppSignature;
    Map sendOtpData = {
      "mobile_number": widget.phoneNumber,
      "app_signature_id": appSignatureID,
      "account": account
    };
    print(sendOtpData);
    Navigator.push(
      // ignore: use_build_context_synchronously
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
                    'assets/images/png/gpay_logo.png',
                    height: 90,
                    width: 70,
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
                                      color: Colors.blue)),
                              TextSpan(
                                  text:
                                      '\n    The Privacy Policy describes how your data is handled. \nGoogle Pay will periodically send your contacts and location \nto Google servers. People with your number can contact you \n access google services and see your public information like \nname and photo. The phone number you have provided can \n                 be used on different Google Services')
                            ]),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {
                              _submit('');
                              if (_googleAccounts.isNotEmpty) {
                                _submit(_googleAccounts
                                    .first); // Or handle multiple selections
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              foregroundColor:
                                  Theme.of(context).primaryColorLight,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text('Accept and continue')),
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
