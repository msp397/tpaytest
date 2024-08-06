import 'package:flutter/material.dart';

class UPIInfoWithQR extends StatelessWidget {
  final String imageUrl;
  final String name;
  const UPIInfoWithQR({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined),
            onSelected: (dynamic value) {},
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 3,
                  child: Text("Set Amount"),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text("Get help"),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text("Send feedback"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          imageUrl.isNotEmpty ? AssetImage(imageUrl) : null,
                      child: imageUrl.isEmpty
                          ? Text(
                              name[0],
                              style: const TextStyle(fontSize: 20),
                            )
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Text(name),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/png/QR.png'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Scan to pay with any UPI app',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/png/SBI-logo.png',
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'State Bank of India 6315',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('UPI ID: ',
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                    const Text(
                      'rahulsakthi@sbi',
                      style: TextStyle(color: Color(0xff666666), fontSize: 12),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.content_copy,
                        size: 16,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('UPI ID copied to Clipboard')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.black, width: 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50),
                        right: Radius.circular(50),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.qr_code_2, color: Colors.black, size: 15),
                      SizedBox(width: 5),
                      Text(
                        'Open scanner',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    side: const BorderSide(color: Colors.white, width: 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50),
                        right: Radius.circular(50),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.black,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Share QR code',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  'Powered by',
                  style: TextStyle(fontSize: 8),
                ),
                SizedBox(
                    height: 20,
                    width: 50,
                    child: Image.asset('assets/images/png/upi_logo.png')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
