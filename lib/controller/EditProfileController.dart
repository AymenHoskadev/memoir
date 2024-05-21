import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoir/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../const.dart';

class EditProfileController extends GetxController {
  CustomUser customUser;
  EditProfileController({required this.customUser});
  final formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();

  void onInit() {
    usernameController = TextEditingController(text: customUser.username);
    emailController =
        TextEditingController(text: supabase.auth.currentUser!.email);
    super.onInit();
  }

  var selectedImagePath = ''.obs;
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();
  final SupabaseClient supabaseClient = Supabase.instance.client;

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  Future<void> uploadImage() async {
    if (selectedImagePath.value.isEmpty) {
      Get.snackbar('Error', 'No image selected');
      return;
    }

    isLoading.value = true;

    final byteData = await XFile(selectedImagePath.value).readAsBytes();
    final fileName = selectedImagePath.value.split('/').last;

    final response = await supabaseClient.storage
        .from('users') // Replace with your actual bucket name
        .uploadBinary(fileName, byteData);
    print(response);
    Get.snackbar('Success', 'Image uploaded successfully');

    isLoading.value = false;
  }
}
