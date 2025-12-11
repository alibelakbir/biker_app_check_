import 'package:get/get.dart';
import 'package:biker_app/app/data/provider/chat_provider.dart';
import 'chat_room_controller.dart';

class ChatRoomBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRoomController(provider: ChatProvider()));
  }
}
