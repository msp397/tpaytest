import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({super.key});

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  List<Widget> _providerList = [];

  void _updateProviderList(String phoneNumber) {
    setState(() {
      print(phoneNumber);
      if (phoneNumber.length > 3) {
        final prefix = phoneNumber[3];
        if (prefix == '9') {
          setState(() {
            _providerList = [
              _buildListTile(
                'Jio',
                'https://th.bing.com/th/id/R.7c8f0d5c7a17a4501ff796a85f91a076?rik=prscf5ZgGFmN8A&riu=http%3a%2f%2flogos-download.com%2fwp-content%2fuploads%2f2016%2f07%2fJio_logo.png&ehk=ez%2fwnkmTwDRiHu7FRE76x%2fu5DKlXSP22m%2bgBOUnuu94%3d&risl=&pid=ImgRaw&r=0',
                'Jio',
              ),
            ];
          });
        } else if (prefix == '8') {
          setState(() {
            _providerList = [
              _buildListTile(
                'Airtel',
                'https://logos-world.net/wp-content/uploads/2020/11/Airtel-Emblem-700x394.png',
                'Airtel',
              ),
            ];
          });
        } else {
          setState(() {
            _providerList = [
              _buildListTile(
                'BSNL',
                'https://th.bing.com/th/id/OIP.B2HpSvdtZ7epON2dk_CudgHaH3?rs=1&pid=ImgDetMain',
                'BSNL',
              ),
            ];
          });
        }
      } else {
        setState(() {
          _providerList = [];
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Recharge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IntlPhoneField(
              decoration: const InputDecoration(
                labelText: 'Mobile number',
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
            Expanded(
              child: ListView(
                children: _providerList,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    print('Recharge button pressed');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Recharge',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
