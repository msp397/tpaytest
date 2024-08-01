import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  // Request specific permissions
  await Permission.contacts.request();
}
