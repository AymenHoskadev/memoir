// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:memoir/view/screens/home.dart';
import 'package:memoir/const.dart';
import 'package:memoir/controller/authController.dart';
import 'package:memoir/view/auth/login.dart';

class RegisterPage extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _controller.formKey,
        child: ListView(
          padding: formPadding,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/educator.svg',
                width: Get.width * 0.65,
                fit: BoxFit.contain,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Commencer à Apprendre',
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
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            formSpacer,
            TextFormField(
              controller: _controller.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de Passe',
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Required';
                }
                if (val.length < 6) {
                  return '6 characters minimum';
                }
                return null;
              },
            ),
            formSpacer,
            TextFormField(
              controller: _controller.usernameController,
              decoration: const InputDecoration(
                labelText: 'Nom et Prenom',
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Required';
                }
                final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
                if (!isValid) {
                  return '3-24 long with alphanumeric or underscore';
                }
                return null;
              },
            ),
            formSpacer,
            Obx(
              () => ElevatedButton(
                onPressed:
                    _controller.isLoading.value ? null : _controller.signUp,
                child: _controller.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: loadingScreen,
                      )
                    : Text(
                        'Cree un Compte',
                        style: TextStyle(color: Colors.black),
                      ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(LoginPage());
              },
              child: const Text(
                'J\'ai deja un compte',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
