import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tpay/components/animatedHintText.dart';
import 'package:tpay/models/userModel.dart';
import 'package:tpay/screens/others/bankTransfer.dart';
import 'package:tpay/screens/others/billsrecharges.dart';
import 'package:tpay/screens/others/business/business.dart';
import 'package:tpay/screens/others/payContact.dart';
import 'package:tpay/screens/others/payUPI.dart';
import 'package:tpay/screens/others/paymentcategory/addbank.dart';
import 'package:tpay/screens/others/paymentcategory/creditcard.dart';
import 'package:tpay/screens/others/paymentcategory/dthrecharge.dart';
import 'package:tpay/screens/others/paymentcategory/electricitybill.dart';
import 'package:tpay/screens/others/paymentcategory/mobileRecharge.dart';
import 'package:tpay/screens/others/payments/chart.dart';
import 'package:tpay/screens/others/payments/managemoney.dart';
import 'package:tpay/screens/others/payments/transactionhistory.dart';
import 'package:tpay/screens/others/profiledetail.dart';
import 'package:tpay/screens/others/scanner.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    setLoaderState();
  }

  void setLoaderState() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  final List<User> users = [
    User(name: 'Alice', avatar: 'assets/images/png/2f41fd.jpg'),
    User(name: 'Bob', avatar: 'assets/images/png/360_F.jpg'),
    User(
      name: 'Charlie',
      avatar: '',
    ),
    User(name: 'David', avatar: 'assets/images/png/close.jpg'),
    User(name: 'Eve', avatar: 'assets/images/png/indian-man.jpg'),
    User(name: 'Frank', avatar: 'assets/images/png/Outdoors.jpg'),
    User(name: 'Grace', avatar: 'assets/images/png/pexels.jpeg'),
    User(name: 'Hannah', avatar: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {},
              ),
              Expanded(
                child: AnimatedHintTextField(
                  controller: _searchController,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).cardColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Profiledetail())),
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: Color.fromARGB(255, 240, 240, 240),
                child: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).cardColor,
                Theme.of(context).cardColor,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).cardColor,
                          Theme.of(context).primaryColorDark,
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Start with your bank',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Send and receive money securely',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddBank()));
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Theme.of(context).cardColor,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text('Add your bank account'),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Skeletonizer(
                enabled: _loading,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMenuItem(
                              Theme.of(context).primaryColor,
                              Icons.qr_code,
                              "Scan QR",
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyScanner(),
                                  ),
                                );
                              },
                            ),
                            _buildMenuItem(
                              Theme.of(context).primaryColor,
                              Icons.phone_android,
                              "Pay phone \n   number",
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PayContact(),
                                  ),
                                );
                              },
                            ),
                            _buildMenuItem(
                              Theme.of(context).primaryColor,
                              Icons.account_balance,
                              "Bank Transfer",
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Banktransfer(),
                                  ),
                                );
                              },
                            ),
                            _buildMenuItem(
                              Theme.of(context).primaryColor,
                              Icons.mobile_friendly,
                              "Pay UPI ID",
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PayUPI(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 12),
                        child: Text(
                          'People',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GridTile(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Chart(),
                                        ));
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        users[index].avatar.isNotEmpty
                                            ? AssetImage(users[index].avatar)
                                            : null,
                                    child: users[index].avatar.isEmpty
                                        ? Text(
                                            users[index].name[0],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          )
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  users[index].name,
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 12),
                            child: Text(
                              'Bills & recharges',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40, bottom: 12),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BillsRecharges()));
                              },
                              child: Text(
                                'Explore',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMenuItem(
                            Theme.of(context).primaryColor,
                            Icons.send_to_mobile,
                            "Mobile \nrecharge",
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MobileRecharge()));
                            },
                          ),
                          _buildMenuItem(
                            Theme.of(context).primaryColor,
                            Icons.credit_card,
                            "Credit cards",
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Creditcard()));
                            },
                          ),
                          _buildMenuItem(
                            Theme.of(context).primaryColor,
                            Icons.tv,
                            "DTH / Cable",
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Dthrecharge()));
                            },
                          ),
                          _buildMenuItem(
                            Theme.of(context).primaryColor,
                            Icons.electric_bolt,
                            "Electricity",
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ElectricityBill()));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 12),
                            child: Text(
                              'Businesses',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40, bottom: 12),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Business()));
                              },
                              child: Text(
                                'Explore',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/png/redbus.png'),
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'redBus',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/png/confirmtlk.png'),
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Confirm Tkt',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/png/png.png'),
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'MakeMyTrip',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/png/channels4_profile.jpg'),
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'InstaMoney',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 12),
                        child: Text(
                          'Offers zone',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                GFAvatar(
                                  size: 30,
                                  shape: GFAvatarShape.standard,
                                  backgroundColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  backgroundImage: NetworkImage(
                                      'https://th.bing.com/th/id/OIP.SgdT7mClMheXgjgx5yEKsAHaHa?rs=1&pid=ImgDetMain'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Rewards'),
                              ],
                            ),
                            SizedBox(width: 45),
                            Column(
                              children: [
                                GFAvatar(
                                  size: 30,
                                  shape: GFAvatarShape.standard,
                                  backgroundColor: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  backgroundImage: NetworkImage(
                                      'https://thumbs.dreamstime.com/b/two-connected-mobile-phones-25729761.jpg'),
                                ),
                                Text('Refer a \n friend'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          'Manage your money',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Managemoney(), // Ensure this widget is defined
                            ),
                          );
                        },
                        leading: const Icon(
                          Icons.account_balance,
                          size: 20,
                        ),
                        title: const Text(
                          'Check bank balance',
                          style: TextStyle(fontSize: 15),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
                      ),
                      GFListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Transactionhistory(), // Ensure this widget is defined
                            ),
                          );
                        },
                        avatar: const Icon(
                          Icons.history,
                          size: 20,
                        ),
                        title: const Text(
                          'See transaction history',
                          style: TextStyle(fontSize: 15),
                        ),
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      Color color, IconData icon, String label, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const SizedBox();
  }
}

class User {
  final String name;
  final String avatar;

  User({required this.name, required this.avatar});
}
