import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tpay/models/userModel.dart';
import 'package:tpay/providers/themeProvider.dart';
import 'package:tpay/screens/others/bankTransfer.dart';
import 'package:tpay/screens/others/scanner.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    setLoaderState();
  }

  void setLoaderState() async {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  final List<User> users = [
    User(name: 'Alice', avatarUrl: 'https://via.placeholder.com/150'),
    User(name: 'Bob', avatarUrl: 'https://via.placeholder.com/150'),
    User(name: 'Charlie', avatarUrl: 'https://via.placeholder.com/150'),
    User(name: 'David', avatarUrl: 'https://via.placeholder.com/150'),
    User(name: 'Eve', avatarUrl: 'https://via.placeholder.com/150'),
    User(name: 'Frank', avatarUrl: 'https://via.placeholder.com/150'),
    User(name: 'Grace', avatarUrl: 'https://via.placeholder.com/150'),
    User(name: 'Hannah', avatarUrl: 'https://via.placeholder.com/150'),
    User(name: 'Ivy', avatarUrl: 'https://via.placeholder.com/150'),
    User(name: 'Jack', avatarUrl: 'https://via.placeholder.com/150'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payments',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 18,
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
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorDark,
                Theme.of(context).cardColor,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMenuItem(Colors.white, Icons.qr_code, "Scan QR",
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyScanner(),
                              ),
                            );
                          }),
                          _buildMenuItem(Colors.white, Icons.account_balance,
                              "Bank Transfer", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Banktransfer(),
                              ),
                            );
                          }),
                          _buildMenuItem(Colors.white, Icons.mobile_friendly,
                              "Pay Contact", () {}),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Skeletonizer(
                  enabled: _loading,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
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
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        NetworkImage(users[index].avatarUrl),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 12),
                          child: Text(
                            'Bills & recharges',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 12),
                              child: _buildMenuItem(
                                  Theme.of(context).primaryColor,
                                  Icons.send_to_mobile,
                                  " Mobile \nrecharge",
                                  () {}),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 12),
                              child: _buildMenuItem(
                                  Theme.of(context).primaryColor,
                                  Icons.credit_card,
                                  "Credit cards",
                                  () {}),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 12),
                              child: _buildMenuItem(
                                  Theme.of(context).primaryColor,
                                  Icons.tv,
                                  "DTH / Cable",
                                  () {}),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 12),
                              child: _buildMenuItem(
                                  Theme.of(context).primaryColor,
                                  Icons.tv,
                                  "DTH / Cable",
                                  () {}),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15, bottom: 12),
                              child: GFAvatar(
                                size: 25,
                                shape: GFAvatarShape.standard,
                                backgroundColor: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                backgroundImage: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.SgdT7mClMheXgjgx5yEKsAHaHa?rs=1&pid=ImgDetMain'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, bottom: 12),
                              child: GFAvatar(
                                size: 25,
                                shape: GFAvatarShape.standard,
                                backgroundColor: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                backgroundImage: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.Y-w0TcBFWY4G-gXMEgu3UgHaE8?rs=1&pid=ImgDetMain'),
                              ),
                            ),
                          ],
                        ),
                        const GFListTile(
                          avatar: Icon(
                            Icons.account_balance,
                            size: 15,
                          ),
                          title: Text(
                            'Check bank balance',
                            style: TextStyle(fontSize: 15),
                          ),
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                          ),
                        ),
                        const GFListTile(
                          avatar: Icon(
                            Icons.history,
                            size: 15,
                          ),
                          title: Text(
                            'See transaction history',
                            style: TextStyle(fontSize: 15),
                          ),
                          icon: Icon(
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
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const Text(
      "",
      style: TextStyle(color: Colors.black),
    );
  }
}

class User {
  final String name;
  final String avatarUrl;

  User({required this.name, required this.avatarUrl});
}
