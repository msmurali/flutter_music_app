import 'package:flutter/material.dart';
import 'src/app.dart';
import './src/data/services/hive_services.dart';

final HiveServices _hiveServices = HiveServices();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _hiveServices.init();
  runApp(const AppWidgetWrapper());
}
