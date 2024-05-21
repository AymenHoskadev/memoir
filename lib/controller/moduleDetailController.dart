import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:memoir/models/ModulePost.dart';
import 'package:memoir/models/user.dart';

class ModuleDetailsController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<ModulePost> modulePosts = <ModulePost>[].obs;
  int idModule;
  ModuleDetailsController({required this.idModule});
  RxList<CustomUser> expertUser = <CustomUser>[].obs;
  @override
  onInit() {
    super.onInit();
    getModulePost();
  }

  @override
  onClose() {
    super.onClose();
    modulePosts = <ModulePost>[].obs;
    isLoading = true.obs;
  }

  getModulePost() async {
    final List response =
        await supabase.from('module_post').select().eq("id_module", idModule);
    modulePosts.value =
        response.map((modulePost) => ModulePost.fromMap(modulePost)).toList();
    update();
    final List response2 = await supabase
        .from('expert_user')
        .select('*, users!user_id!inner(*)')
        .eq("module_id", idModule);
    expertUser.value = response2
        .map((expertUser) => CustomUser.fromMap(expertUser['users']))
        .toList();
    expertUser.sort((a, b) {
      if (b.status) {
        return 1;
      }
      return -1;
    });
    isLoading.value = false;
    update();
  }
}
