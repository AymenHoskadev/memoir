import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoir/controller/EditProfileController.dart';
import 'package:memoir/models/user.dart';

class EditProfile extends StatelessWidget {
  CustomUser customUser;
  EditProfile({required this.customUser});

  @override
  Widget build(BuildContext context) {
    EditProfileController controller =
        EditProfileController(customUser: customUser);
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier votre Profil'),
      ),
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.selectedImagePath.value.isNotEmpty)
              Image.file(File(controller.selectedImagePath.value)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  controller.isLoading.value ? null : controller.uploadImage,
              child: controller.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Upload Image'),
            ),
          ],
        );
      }),
    );
  }
}
