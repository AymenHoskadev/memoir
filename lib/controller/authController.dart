import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoir/view/screens/home.dart';
import 'package:memoir/const.dart';
import 'package:memoir/utils/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  Future<void> signUp() async {
    isLoading.value = true;
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
      return;
    }
    final email = emailController.text;
    final password = passwordController.text;
    final username = usernameController.text;
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username, 'email': email, 'role': 'Student'},
      );
      isLoading.value = false;
      Get.offAll(HomePage());
    } on AuthException catch (error) {
      Get.snackbar("Error", error.message);
      isLoading.value = false;
    } catch (error) {
      Get.snackbar("Error", error.toString());
      isLoading.value = false;
    }
  }

  Future<void> signIn() async {
    isLoading.value = true;
    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAll(HomePage());
      isLoading.value = false;
    } on AuthException catch (error) {
      Get.snackbar("Error", error.message);
      isLoading.value = false;
    } catch (_) {
      // Handle unexpected errors
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  signOut() async {
    print('logout');
    supabase.auth.signOut();
    Get.offAll(SplashPage());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
