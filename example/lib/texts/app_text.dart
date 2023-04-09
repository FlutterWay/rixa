// ignore_for_file: non_constant_identifier_names

import 'package:rixa/rixa.dart';

class AppTexts {
  static String get ok => RixaText(["ok", "tamam"]).text;
  static String get hello => RixaText(["Hello", "Merhaba"]).text;
  static String get lang => RixaText(["Language", "Dil"]).text;
  static String get page => RixaText(["Page", "Sayfa"]).text;
  static String get login => RixaText(["Login", "Giriş"]).text;
  static String get widgets => RixaText(["Widgets", "Widgetlar"]).text;
  static String get appbar_title =>
      RixaText(["Rixa App Design", "Akıllı Uygulama Tasarımı"]).text;
  static String get settings => RixaText(["Settings", "Ayarlar"]).text;
  static String get signout => RixaText(["Signout", "Çıkış"]).text;
  static String get goToNested => RixaText([
        "Go to Nested Page version of Page2",
        "Sayfa 2'nin NestedPage versiyonuna git"
      ]).text;
  static String get darkMode => RixaText(["Dark Mode", "Karanlık Mod"]).text;
  static String get btnText => RixaText([
        "You have pushed the button this many times",
        "Düğmeye bukadar çok bastın",
      ]).text;
  static List<String> get languages => RixaList([
        ["English", "Turkish"],
        ["İngilizce", "Türkçe"]
      ]).texts;
  static List<String> get menus => RixaList([
        ["Page 1", "Page 2", "Settings", "Signout"],
        ["Sayfa 1", "Sayfa 2", "Ayarlar", "Çıkış"]
      ]).texts;
}
