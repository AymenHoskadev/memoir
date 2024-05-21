import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:memoir/models/user.dart';
import '../models/chat.dart';

class ChatController extends GetxController {
  RxList<Chat> chats = <Chat>[].obs;
  RxList<CustomUser> chatUsers = <CustomUser>[].obs;
  RxList<CustomUser> allUsers = <CustomUser>[].obs;

  @override
  onInit() {
    super.onInit();
    getChats();
  }

  getChats() async {
    List response = await supabase
        .from('chats')
        .select()
        .contains('users_id', [supabase.auth.currentUser!.id]);
    chats.value = response.map((chat) => Chat.fromMap(chat)).toList();
    print(chats);

    List reponse2 = await supabase.from('users').select();
    allUsers.value = reponse2.map((user) => CustomUser.fromMap(user)).toList();

    /* for (Chat c in chats) {
      c.usersID.forEach((element) {
        if (supabase.auth.currentUser!.id != element) print(element);
      });
    }*/

    chatUsers.value = getUsersInChats(allUsers, chats);
  }

  List<CustomUser> getUsersInChats(
      List<CustomUser> allUsers, List<Chat> chats) {
    // Initialize a set to store unique user IDs that are in chats
    Set<String> usersInChats = Set();

    // Iterate through each chat
    for (var chat in chats) {
      // Add all user IDs in the current chat to the set
      usersInChats.addAll(chat.usersID.map((userId) => userId.toString()));
    }

    // Filter the list of all users to include only those whose IDs are in the set of users in chats,
    // but exclude the currentUserId
    List<CustomUser> usersInChatsList = allUsers
        .where((user) =>
            usersInChats.contains(user.id) &&
            user.id != supabase.auth.currentUser!.id)
        .toList();

    return usersInChatsList;
  }
}
