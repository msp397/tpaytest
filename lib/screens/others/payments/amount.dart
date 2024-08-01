import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double amount = 0.0;

  void _updateMoney(double newAmount) {
    setState(() {
      amount += newAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 22,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/1.jpg'),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                        ),
                        CircleAvatar(
                          radius: 22,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/4.jpg'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Paying via",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(width: 10),
                        const CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(
                              'https://th.bing.com/th/id/R.7c8f0d5c7a17a4501ff796a85f91a076?rik=prscf5ZgGFmN8A&riu=http%3a%2f%2flogos-download.com%2fwp-content%2fuploads%2f2016%2f07%2fJio_logo.png&ehk=ez%2fwnkmTwDRiHu7FRE76x%2fu5DKlXSP22m%2bgBOUnuu94%3d&risl=&pid=ImgRaw&r=0'),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "prepaid",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MoneyDisplay(amount: amount),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRoundedBadge(100),
                    const SizedBox(width: 8),
                    _buildRoundedBadge(500),
                    const SizedBox(width: 8),
                    _buildRoundedBadge(1000),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedBadge(double amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          _updateMoney(amount);
        },
        child: Text(
          '+ ${amount.toInt()}',
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}

class MoneyDisplay extends StatelessWidget {
  final double amount;

  const MoneyDisplay({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final text = amount > 0 ? '₹${amount.toStringAsFixed(2)}' : '₹0';
    final textWidth = _calculateTextWidth(text, context);
    const minWidth = 200.0;
    final containerWidth = textWidth > minWidth ? textWidth : minWidth;

    return Column(
      children: [
        Container(
          width: containerWidth,
          padding: const EdgeInsets.only(bottom: 20),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  double _calculateTextWidth(String text, BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    return textPainter.size.width;
  }
}
