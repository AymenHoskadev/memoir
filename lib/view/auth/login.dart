// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:memoir/view/auth/register.dart';
import 'package:memoir/view/screens/home.dart';
import 'package:memoir/controller/authController.dart';

class LoginPage extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: formPadding,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/images/minnions.svg',
              width: Get.width * 0.65,
              fit: BoxFit.contain,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Entrez vos Coordonnées',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                '.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 40),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _controller.emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          formSpacer,
          TextFormField(
            controller: _controller.passwordController,
            decoration: const InputDecoration(labelText: 'Mot de Passe'),
            obscureText: true,
          ),
          formSpacer,
          Obx(
            () => ElevatedButton(
              onPressed:
                  _controller.isLoading.value ? null : _controller.signIn,
              child: _controller.isLoading.value
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: loadingScreen,
                    )
                  : Text(
                      'Se Connecter',
                      style: TextStyle(color: Colors.black),
                    ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.offAll(RegisterPage());
            },
            child: const Text(
              'Creer un nouveau compte',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
