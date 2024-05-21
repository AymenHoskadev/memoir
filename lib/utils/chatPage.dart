import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:memoir/controller/messageController.dart';
import 'package:memoir/models/message.dart';

class ChatPage extends StatelessWidget {
  final String otherUserID;
  final String otherUserName;
  ChatPage({required this.otherUserID, required this.otherUserName});

  @override
  Widget build(BuildContext context) {
    MessageController messageController = Get.put(MessageController(
        otherUserID: otherUserID, otherUserName: otherUserName));
    TextEditingController messageControllerText = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(otherUserName),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
              Get.delete<MessageController>();
            },
          ),
        ),
        body: Obx(
          () => messageController.isLoading.value
              ? loadingScreen
              : StreamBuilder(
                  stream: messageController.messages,
                  builder: (context, snapshot) {
                    List<Message> messages = snapshot.data ?? [];

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              Message message = messages[index];
                              bool isSent = message.senderID == otherUserID;

                              return Align(
                                alignment: isSent
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isSent
                                        ? primaryColor
                                        : const Color.fromARGB(
                                            255, 127, 127, 127),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    message.content,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: messageControllerText,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your message...',
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  if (messageControllerText.text.isNotEmpty) {
                                    messageController.sendMessage(
                                        messageControllerText.text);
                                    messageControllerText.clear();
                                  }
                                },
                                child: Text('Send'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ));
  }
}
