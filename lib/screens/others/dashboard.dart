import 'package:flutter/material.dart';
import 'package:tpay/screens/others/bankTransfer.dart';
import 'package:tpay/screens/others/scanner.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade500,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
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
                      // const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // _buildMenuItem(Icons.local_atm, "A/C ATM"),
                          // _buildMenuItem(Icons.account_balance, "A/C balance"),
                          // _buildMenuItem(
                          //     Icons.account_balance_wallet, "A/C wallet"),
                          // _buildMenuItem(Icons.account_box, "A/C box"),
                          // _buildMenuItem(Icons.account_tree, "A/C tree"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
              Scaffold.of(context).openDrawer();
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
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
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.blue,
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
