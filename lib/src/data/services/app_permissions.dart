import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static Future<PermissionStatus> requestPermissions() async {
    return await Permission.storage.request();
  }

  static Future<bool> checkPermissions() async {
    if (await Permission.storage.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
