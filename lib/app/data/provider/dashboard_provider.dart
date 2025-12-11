import 'package:biker_app/app/data/api/api_connect.dart';
import 'package:biker_app/app/utils/constants.dart';

class DashboardProvider {
  DashboardProvider();

  Future<int> getUnseenNotificationCount(String lastSeenDate) async {
    final resp = (await ApiConnect.instance
            .get('${EndPoints.notificationCount}?lastSeenDate=$lastSeenDate'))
        .getBody();
    return resp['total'];
  }
}
