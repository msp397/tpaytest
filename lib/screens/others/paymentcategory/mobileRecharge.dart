import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permission_handler/permission_handler.dart';

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({super.key});

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  List<Widget> _providerList = [];
  List<Contact> _contacts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _updateProviderList(String phoneNumber) {
    setState(() {
      print(phoneNumber);
      if (phoneNumber.length > 3) {
        final prefix = phoneNumber[3];
        if (prefix == '9') {
          _providerList = [
            _buildListTile(
              'Jio',
              'https://th.bing.com/th/id/R.7c8f0d5c7a17a4501ff796a85f91a076?rik=prscf5ZgGFmN8A&riu=http%3a%2f%2flogos-download.com%2fwp-content%2fuploads%2f2016%2f07%2fJio_logo.png&ehk=ez%2fwnkmTwDRiHu7FRE76x%2fu5DKlXSP22m%2bgBOUnuu94%3d&risl=&pid=ImgRaw&r=0',
              'Jio',
            ),
          ];
        } else if (prefix == '8') {
          _providerList = [
            _buildListTile(
              'Airtel',
              'https://logos-world.net/wp-content/uploads/2020/11/Airtel-Emblem-700x394.png',
              'Airtel',
            ),
          ];
        } else {
          _providerList = [
            _buildListTile(
              'BSNL',
              'https://th.bing.com/th/id/OIP.B2HpSvdtZ7epON2dk_CudgHaH3?rs=1&pid=ImgDetMain',
              'BSNL',
            ),
          ];
        }
      } else {
        _providerList = [];
      }
    });
  }

  ListTile _buildListTile(String title, String imageUrl, String logMessage) {
    return ListTile(
      leading: Image.network(
        imageUrl,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      title: Text(title),
      onTap: () {
        print('$logMessage selected');
      },
    );
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
      appBar: AppBar(
        title: const Text('Mobile recharge'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined),
            onSelected: (dynamic value) {
              // Handle menu actions here
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text("Get help"),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text("Send feedback"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Enter mobile number',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 12),
            IntlPhoneField(
              autovalidateMode: AutovalidateMode.disabled,
              decoration: const InputDecoration(
                hintText: 'Mobile number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                setState(() {
                  _updateProviderList(phone.completeNumber);
                });
              },
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 15, bottom: 12),
              child: Text(
                'My contacts',
                style: TextStyle(fontSize: 18),
              ),
            ),
            if (_loading)
              const Center()
            else if (_contacts.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    final contact = _contacts[index];
                    return Column(
                      children: [
                        Column(
                          children: _providerList,
                        ),
                        ListTile(
                          leading: contact.avatar != null &&
                                  contact.avatar!.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar!),
                                )
                              : CircleAvatar(
                                  child:
                                      Text(contact.displayName.toString()[0]),
                                ),
                          title: Text(contact.displayName ?? 'No Name'),
                          subtitle: contact.phones!.isNotEmpty
                              ? Text(contact.phones!.first.value ??
                                  'No Phone Number')
                              : null,
                        ),
                      ],
                    );
                  },
                ),
              )
            else
              const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryColorLight,
        onPressed: () {
          print('Recharge button pressed');
        },
        child: const Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }
}
