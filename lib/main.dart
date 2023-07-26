import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/ui/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'bindings/data_bindings.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Olx App',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const SplashScreen(),initialBinding: DataBindings(),
    );
  }
}

