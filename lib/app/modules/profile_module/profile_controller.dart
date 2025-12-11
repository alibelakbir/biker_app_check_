import 'package:biker_app/app/data/model/app_user.dart';
import 'package:get/get.dart';
import '../../../app/data/provider/profile_provider.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';

class ProfileController extends GetxController with AnalyticsMixin {
  final ProfileProvider? provider;
  ProfileController({this.provider});

  final Rxn<AppUser> _appUser = Rxn<AppUser>();
  AppUser? get appUser => _appUser.value;

  setAppUser(AppUser? user) => _appUser.value = user;


  
}
