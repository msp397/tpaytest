import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tpay/screens/others/payments/amount.dart';

class PayContact extends StatefulWidget {
  const PayContact({super.key});

  @override
  State<PayContact> createState() => _PayContactState();
}

class _PayContactState extends State<PayContact> {
  final TextEditingController _searchController = TextEditingController();
  List<Contact> _allContacts = [];
  List<Contact> _filteredContacts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
    _searchController.addListener(() {
      _filterContacts(_searchController.text);
    });
  }

  void _filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = _allContacts;
      } else {
        _filteredContacts = _allContacts.where((contact) {
          final nameContainsQuery = contact.displayName != null &&
              contact.displayName!.toLowerCase().contains(query.toLowerCase());
          final phoneContainsQuery = contact.phones != null &&
              contact.phones!.any((phone) =>
                  phone.value != null && phone.value!.contains(query));

          return nameContainsQuery || phoneContainsQuery;
        }).toList();
      }
    });
  }

  Future<void> _loadContacts() async {
    var permissionStatus = await Permission.contacts.request();

    if (permissionStatus.isGranted) {
      try {
        List<Contact> contacts = (await ContactsService.getContacts()).toList();
        setState(() {
          _allContacts = contacts;
          _filteredContacts = contacts;
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(color: Colors.grey.shade300, blurRadius: 5.0)
            ],
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _filteredContacts.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _filteredContacts.length,
                          itemBuilder: (context, index) {
                            final contact = _filteredContacts[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: contact.avatar != null &&
                                          contact.avatar!.isNotEmpty
                                      ? CircleAvatar(
                                          backgroundImage:
                                              MemoryImage(contact.avatar!),
                                        )
                                      : CircleAvatar(
                                          child: Text(contact.displayName
                                              .toString()[0]),
                                        ),
                                  title: Text(contact.displayName ?? 'No Name'),
                                  subtitle: contact.phones!.isNotEmpty
                                      ? Text(contact.phones!.first.value ??
                                          'No Phone Number')
                                      : null,
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PaymentScreen()));
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
