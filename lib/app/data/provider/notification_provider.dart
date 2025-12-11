import 'package:biker_app/app/data/api/api_connect.dart';
import 'package:biker_app/app/data/model/notification.dart';
import 'package:biker_app/app/utils/constants.dart';

class NotificationProvider {
  NotificationProvider();

  Future<List<AppNotification>> getNotifications() async {
    final resp = (await ApiConnect.instance.get(EndPoints.notification))
        .getBody() as List;
    return resp.map((e) => AppNotification.fromMap(e)).toList();
  }
}
