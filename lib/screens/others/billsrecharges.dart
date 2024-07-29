import 'package:flutter/material.dart';

class BillsRecharges extends StatefulWidget {
  const BillsRecharges({super.key});

  @override
  _BillsRechargesState createState() => _BillsRechargesState();
}

class _BillsRechargesState extends State<BillsRecharges> {
  bool _showMore = false;
  bool _expanWithheader = false;

  final List<_MenuItem> _allMenuItems = [
    _MenuItem(
        icon: Icons.phone_android, label: 'Mobile \nRecharge', onTap: () {}),
    _MenuItem(
        icon: Icons.lightbulb_outline,
        label: 'Electricity \nBill',
        onTap: () {}),
    _MenuItem(icon: Icons.dvr_outlined, label: 'DTH Recharge', onTap: () {}),
    _MenuItem(icon: Icons.wifi, label: 'Internet Bill', onTap: () {}),
    _MenuItem(icon: Icons.water_drop, label: 'Water Bill', onTap: () {}),
    _MenuItem(icon: Icons.local_gas_station, label: 'Gas Bill', onTap: () {}),
    _MenuItem(icon: Icons.monetization_on, label: 'Loan Payment', onTap: () {}),
    _MenuItem(icon: Icons.subscriptions, label: 'Subscription', onTap: () {}),
    _MenuItem(icon: Icons.taxi_alert, label: 'Taxi', onTap: () {}),
    _MenuItem(icon: Icons.local_hospital, label: 'Hospital', onTap: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Feedback'),
                    content: const Text(
                      'Send feedback functionality can be implemented here.',
                    ),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_expanWithheader) _buildHeader(),
            // if (!_expanWithheader) _buildHeader(),
            _buildMenuGrid(
              _showMore && _expanWithheader
                  ? []
                  : _allMenuItems.take(6).toList(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                padding: const EdgeInsets.all(16.0),
              ),
              onPressed: () {
                setState(() {
                  _expanWithheader = true;
                  _showMore = !_showMore;
                });
              },
              child: Text(_showMore ? 'Show Less' : 'View All'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_showMore) ...[
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Payment Categories",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          _buildSectionHeader('Recharge', [
            _MenuItem(
                icon: Icons.phone_android,
                label: 'Mobile \nRecharge',
                onTap: () {}),
            _MenuItem(
                icon: Icons.lightbulb_outline,
                label: 'Electricity \nBill',
                onTap: () {}),
            _MenuItem(
                icon: Icons.dvr_outlined, label: 'DTH Recharge', onTap: () {}),
            _MenuItem(icon: Icons.wifi, label: 'Internet Bill', onTap: () {}),
          ]),
          _buildSectionHeader('Utility Bills', [
            _MenuItem(
                icon: Icons.water_drop, label: 'Water Bill', onTap: () {}),
            _MenuItem(
                icon: Icons.local_gas_station, label: 'Gas Bill', onTap: () {}),
          ]),
          _buildSectionHeader('Finance & Tax', [
            _MenuItem(
                icon: Icons.monetization_on,
                label: 'Loan Payment',
                onTap: () {}),
            _MenuItem(
                icon: Icons.subscriptions, label: 'Subscription', onTap: () {}),
            _MenuItem(icon: Icons.taxi_alert, label: 'Taxi', onTap: () {}),
          ]),
          _buildSectionHeader('More', [
            _MenuItem(
                icon: Icons.local_hospital, label: 'Hospital', onTap: () {}),
          ]),
          //_buildSectionHeader('Set Up Regular Payments', []),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        if (items.isNotEmpty) _buildMenuGrid(items),
      ],
    );
  }

  Widget _buildMenuGrid(List<_MenuItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildMenuItem(
          icon: item.icon,
          label: item.label,
          onTap: item.onTap,
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 231, 238, 245),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Icon(icon, color: Colors.black),
              radius: 30.0,
              backgroundColor: Colors.transparent,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _MenuItem({required this.icon, required this.label, required this.onTap});
}
