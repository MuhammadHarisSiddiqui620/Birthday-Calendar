import 'package:birthday_calendor/Models/birthday_model.dart';
import 'package:birthday_calendor/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(
      BirthdayModelAdapter()); // Register the generated adapter

/*  if (!Hive.isBoxOpen('alarm-db')) {
    var box = await Hive.openBox<BirthdayModel>('birthday-db');
    await box.clear(); // Only clear if successfully opened
  }*/

  // Ensure the box is only opened once
  if (!Hive.isBoxOpen('birthday-db')) {
    await Hive.openBox<BirthdayModel>('birthday-db');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
    );
  }
}
