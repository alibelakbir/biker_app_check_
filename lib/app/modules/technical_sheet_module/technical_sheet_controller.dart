import 'package:get/get.dart';
import '../../../app/data/provider/technical_sheet_provider.dart';

class TechnicalSheetController extends GetxController {
  final TechnicalSheetProvider? provider;
  TechnicalSheetController({this.provider});

  final _text = 'TechnicalSheet'.obs;
  set text(text) => _text.value = text;
  get text => _text.value;
}
