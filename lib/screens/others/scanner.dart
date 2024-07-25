import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyScanner extends StatefulWidget {
  const MyScanner({super.key});

  @override
  _MyScannerState createState() => _MyScannerState();
}

class _MyScannerState extends State<MyScanner> {
  String scannedData = "Scan a code";
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Camera view or background goes here (not included in the example)
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  scannedData,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: scanQR,
                  child: Text('Toggle Flash'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedData = scanData.code!;
      });
    });
  }

  Future<void> scanQR() async {
    try {
      await controller.toggleFlash();
    } catch (e) {
      print('Error toggling flash: $e');
    }
  }
}
