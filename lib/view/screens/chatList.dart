import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:memoir/controller/chatController.dart';
import 'package:memoir/models/user.dart';
import 'package:memoir/utils/chatPage.dart';
import 'package:memoir/utils/profile.dart';

class ChatPageList extends StatelessWidget {
  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              'Mes Contacts',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: chatController.chatUsers.length,
            itemBuilder: (BuildContext context, int index) {
              CustomUser user = chatController.chatUsers[index];
              return InkWell(
                onTap: () {
                  Get.to(ChatPage(
                      otherUserID: user.id, otherUserName: user.username));
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileWidget(
                        user: user,
                      )),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
