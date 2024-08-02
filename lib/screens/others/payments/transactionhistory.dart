import 'package:flutter/material.dart';

class Transactionhistory extends StatefulWidget {
  const Transactionhistory({super.key});

  @override
  State<Transactionhistory> createState() => _TransactionhistoryState();
}

class _TransactionhistoryState extends State<Transactionhistory> {
  String searchQuery = '';

  // Dummy data for transactions
  final List<Map<String, String>> transactions = [
    {'name': 'John Doe', 'amount': '\$200', 'avatar': 'assets/avatar1.png'},
    {'name': 'Jane Smith', 'amount': '\$150', 'avatar': 'assets/avatar2.png'},
    {
      'name': 'Michael Brown',
      'amount': '\$300',
      'avatar': 'assets/avatar3.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search Transactions...',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            setState(() {
              searchQuery = query;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // You can add additional search logic here if needed
            },
          ),
        ],
      ),
      body: ListView(
        children: transactions.where((transaction) {
          return transaction['name']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
        }).map((transaction) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(transaction['avatar']!),
            ),
            title: Text(transaction['name']!),
            subtitle: Text(transaction['amount']!),
          );
        }).toList(),
      ),
    );
  }
}
