import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:memoir/controller/homeController.dart';
import 'package:memoir/view/screens/home.dart';
import 'package:memoir/const.dart';
import 'package:memoir/view/auth/register.dart';

/// Page to redirect users to the appropriate page depending on the initial auth state
class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  HomeController home = Get.put(HomeController());
  @override
  void initState() {
    super.initState();

    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration(seconds: 35));

    final session = supabase.auth.currentSession;
    if (session == null) {
      Get.offAll(RegisterPage());
    } else {
      Get.offAll(HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/logoSplash.png')),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/loading.gif',
              height: 100,
            )
          ],
        ),
      ),
    ));
  }
}
