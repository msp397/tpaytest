import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpay/providers/themeProvider.dart';
import 'package:tpay/screens/others/bankTransfer.dart';
import 'package:tpay/screens/others/scanner.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
      body: Expanded(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorLight,
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
                          _buildMenuItem(Icons.qr_code, "Scan QR", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyScanner()));
                          }),
                          _buildMenuItem(Icons.account_balance, "Bank Transfer",
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Banktransfer()));
                          }),
                          // _buildMenuItem(Icons.payment, "Payment"),
                          // _buildMenuItem(Icons.call, "Call"),
                          // _buildMenuItem(Icons.message, "Message"),
                          _buildMenuItem(
                              Icons.account_circle, "Account", () {}),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            "Payments",
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildFooter() {
  return const Text(
    "",
    style: TextStyle(color: Colors.black),
  );
}
