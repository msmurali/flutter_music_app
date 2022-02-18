import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/utils/initializer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  );

  Widget app = await Initializer.initApp();
  runApp(app);
}
