// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoir/controller/authController.dart';
import 'package:memoir/controller/homeController.dart';
import 'package:memoir/view/screens/editProfile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  AuthController auth = Get.find<AuthController>();
  HomeController home = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //profile
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Profile Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 120,
            child: InkWell(
              onTap: () {
                Get.to(EditProfile(customUser: home.currentUser.value!));
              },
              child: Card(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(home.currentUser.value!.image),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          home.currentUser.value!.username,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          home.currentUser.value!.role,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
            ),
          ),
          //dark mode
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'More Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                SettingMenu(
                  function: () {},
                  text: 'Nos Contacter',
                  icon: Icons.phone,
                  color: Colors.green,
                ),
                const Divider(
                  color: Color.fromARGB(255, 179, 179, 179),
                  thickness: 1.0,
                ),
                SettingMenu(
                  function: () {
                    Get.defaultDialog(
                        titlePadding: EdgeInsets.all(15),
                        title: "Voulez vous vraiment se deconnecter",
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        titleStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                        textConfirm: "Confirmer",
                        textCancel: "Cancel",
                        cancelTextColor: const Color.fromARGB(255, 0, 0, 0),
                        confirmTextColor: Colors.white,
                        buttonColor: Colors.red,
                        barrierDismissible: true,
                        radius: 10,
                        onConfirm: auth.signOut,
                        content: Container());
                  },
                  text: 'Se Deconnecter',
                  icon: Icons.logout,
                  color: Colors.red,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingMenu extends StatelessWidget {
  IconData icon;
  Color color;
  String text;
  Function function;

  SettingMenu({
    Key? key,
    required this.color,
    required this.icon,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: InkWell(
        onTap: () {
          function();
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.23),
              child: Icon(icon, color: color),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
