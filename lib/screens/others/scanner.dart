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
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.flash_on, color: Colors.white),
                  onPressed: scanQR,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              scannedData,
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
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
