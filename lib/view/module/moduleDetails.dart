import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:memoir/controller/authController.dart';
import 'package:memoir/controller/moduleController.dart';
import 'package:memoir/controller/moduleDetailController.dart';
import 'package:memoir/models/ModulePost.dart';
import 'package:memoir/models/module.dart';
import 'package:memoir/models/user.dart';
import 'package:memoir/utils/chatPage.dart';
import 'package:memoir/utils/profile.dart';

class ModuleDetails extends StatelessWidget {
  final Module module;

  ModuleDetails({required this.module});

  @override
  Widget build(BuildContext context) {
    final ModuleDetailsController controller =
        Get.put(ModuleDetailsController(idModule: module.id));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          module.title,
          maxLines: 2,
          softWrap: true,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        final List<ModulePost> modulePosts = controller.modulePosts;
        final List<CustomUser> expertUser = controller.expertUser;
        return controller.isLoading.value
            ? loadingScreen
            : ListView.builder(
                itemCount: modulePosts.length,
                itemBuilder: (BuildContext context, int index) {
                  ModulePost post = modulePosts[index];
                  return Card(
                    child: ExpansionTile(
                      title: Text(post.title),
                      children: [
                        Image.network(post.image),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "List des Tuteurs",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 300,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: expertUser.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(() => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          Get.to(ChatPage(
                                            otherUserID: expertUser[index].id,
                                            otherUserName:
                                                expertUser[index].username,
                                          ));
                                        },
                                        child: ProfileWidget(
                                          user: expertUser[index],
                                        )),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
      }),
    );
  }
}
