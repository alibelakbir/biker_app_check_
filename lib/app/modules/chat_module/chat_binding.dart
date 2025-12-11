import 'package:get/get.dart';

import '../../../app/data/provider/chat_provider.dart';
import '../../../app/modules/chat_module/chat_controller.dart';
   
class ChatBinding implements Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;
    Get.lazyPut<ChatController>(
      () => ChatController(
        provider: ChatProvider(),
        receiverId: args['receiverId'],
        receiverName: args['receiverName'],
        receiverPhone: args['receiverPhone'],
        ad: args['ad'],
        roomId: args['roomId'],
      ),
    );
  }
}
