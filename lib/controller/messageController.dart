import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:memoir/models/chat.dart';
import 'package:memoir/models/message.dart';
import 'package:rxdart/rxdart.dart';

class MessageController extends GetxController {
  String otherUserID;
  String otherUserName;
  MessageController({required this.otherUserID, required this.otherUserName});

  late final Stream<List<Message>> messages;

  RxBool isLoading = true.obs;
  RxInt chatID = 0.obs;

  @override
  onInit() {
    super.onInit();
    getMessages();
  }

  getMessages() async {
    var data = await supabase
        .from('chats')
        .select()
        .contains('users_id', [supabase.auth.currentUser!.id, otherUserID]);
    if (data.toString() == '[]') {
      data = await supabase.from('chats').insert({
        "users_id": [supabase.auth.currentUser!.id, otherUserID],
      }).select();
    }
    chatID.value = data[0]['id'];
    messages = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatID.value)
        .order('created_at')
        .map((maps) => maps.map((map) => Message.fromMap(map)).toList());

    isLoading.value = false;

    update();
  }

  Future<void> sendMessage(String messageText) async {
    final currentUserID = supabase.auth.currentUser!.id;

    try {
      final response = await supabase.from('messages').insert({
        'chat_id': chatID.value,
        'content': messageText,
        'sender_id': currentUserID
      });
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
