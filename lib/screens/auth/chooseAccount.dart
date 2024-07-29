import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tpay/screens/auth/otpVerification.dart';

class ChooseAccount extends StatefulWidget {
  final String phoneNumber;
  const ChooseAccount({super.key, required this.phoneNumber});

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  List<Contact> _contacts = [];
  bool _loading = true;

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
          _loading = false;
        });
      } catch (e) {
        setState(() {
          _loading = false;
        });
        print('Error fetching contacts: $e');
      }
    } else {
      setState(() {
        _loading = false;
      });
    }
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
                  padding: const EdgeInsets.only(right: 300),
                  child: SizedBox(
                    height: 70,
                    width: 80,
                    child: Image.asset('assets/images/png/gpay_logo.png'),
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
                  child: _loading
                      ? Center(child: CircularProgressIndicator())
                      : ListView(
                          children: _contacts
                              .where((contact) => contact.emails!.isNotEmpty)
                              .map((contact) => ListTile(
                                    title:
                                        Text(contact.displayName ?? 'No Name'),
                                    subtitle: Text(
                                        contact.emails!.first.value ??
                                            'No Email'),
                                  ))
                              .toList(),
                        ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Terms and Conditions'),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Otpverification(
                                    phonenumber: widget.phoneNumber,
                                  ),
                                ),
                              );
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
