import 'package:get/get.dart';
import '../states/app_settings.dart';

class RixaText {
  List<String> meanings = [];
  RixaText(this.meanings);
  String get text {
    return meanings[Get.find<AppSettings>().getIndexOfLang()];
  }
}

class RixaList {
  List<List<String>> meanings = [];
  RixaList(this.meanings);
  List<String> get texts {
    return meanings[Get.find<AppSettings>().getIndexOfLang()];
  }
}
