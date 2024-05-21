import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:memoir/utils/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    // TODO: Replace credentials with your own
    url: 'https://shcmfrgkvicvtxwdskrl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNoY21mcmdrdmljdnR4d2Rza3JsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE1NzExNzQsImV4cCI6MjAyNzE0NzE3NH0.3kVZQpab2veKtK8MDQGMHGrONKSdazLVBt4HzWhdbDM',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Chat App',
      theme: appTheme,
      home: SplashPage(),
    );
  }
}
