import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tpay/screens/auth/otpVerification.dart';

class AccountSelection extends StatefulWidget {
  final String phoneNumber;
  const AccountSelection({super.key, required this.phoneNumber});

  @override
  State<AccountSelection> createState() => _AccountSelectionState();
}

class _AccountSelectionState extends State<AccountSelection> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    var permissionStatus = await Permission.contacts.request();

    if (permissionStatus.isGranted) {
      try {
        List<Contact> contacts = (await ContactsService.getContacts()).toList();
        setState(() {
          _contacts = contacts;
        });
      } catch (e) {
        print('Error fetching contacts: $e');
      }
    } else {
      print('Error fetching contacts:');
    }
  }

  Widget _buildAvatar(Contact contact) {
    if (contact.avatar != null && contact.avatar!.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: MemoryImage(contact.avatar!),
        radius: 24,
      );
    } else {
      String initials = _getAvatarText(contact.displayName);
      return CircleAvatar(
        backgroundColor: Colors.blueAccent,
        radius: 24,
        child: Text(
          initials,
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  String _getAvatarText(String? name) {
    if (name == null || name.isEmpty) {
      return '';
    }
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}';
    } else {
      return name.substring(0, 2).toUpperCase();
    }
  }

  void _submit() async {
    var appSignatureID = await SmsAutoFill().getAppSignature;
    Map sendOtpData = {
      "mobile_number": widget.phoneNumber.toString(),
      "app_signature_id": appSignatureID
    };
    print(sendOtpData);
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
                  child: ListView(
                    children: _contacts
                        .where((contact) => contact.emails!.isNotEmpty)
                        .map((contact) => ListTile(
                              title: Text(contact.displayName ?? 'No Name'),
                              leading: _buildAvatar(contact),
                              subtitle: Text(
                                  contact.emails!.first.value ?? 'No Email'),
                            ))
                        .toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Terms and Conditions'),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: _submit,
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
