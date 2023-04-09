import 'package:flutter_emoji_gif_picker/flutter_emoji_gif_picker.dart'
    as flutter_emoji_gif_picker;

class EmojiGifPickerPanel {
  static bool onWillPop() {
    return flutter_emoji_gif_picker.EmojiGifPickerPanel.onWillPop();
  }

  static setPosition(flutter_emoji_gif_picker.MenuPosition position) {
    flutter_emoji_gif_picker.EmojiGifPickerPanel.setPosition(position);
  }

  static flutter_emoji_gif_picker.MenuPosition get position =>
      flutter_emoji_gif_picker.EmojiGifPickerPanel.position;

  static setSizes(flutter_emoji_gif_picker.MenuSizes sizes) {
    flutter_emoji_gif_picker.EmojiGifPickerPanel.setSizes(sizes);
  }

  static flutter_emoji_gif_picker.MenuSizes get sizes =>
      flutter_emoji_gif_picker.EmojiGifPickerPanel.sizes;

  static setTexts(flutter_emoji_gif_picker.MenuTexts texts) {
    flutter_emoji_gif_picker.EmojiGifPickerPanel.setTexts(texts);
  }

  static flutter_emoji_gif_picker.MenuTexts get texts =>
      flutter_emoji_gif_picker.EmojiGifPickerPanel.texts;

  static setColors(flutter_emoji_gif_picker.MenuColors colors) {
    flutter_emoji_gif_picker.EmojiGifPickerPanel.setColors(colors);
  }

  static flutter_emoji_gif_picker.MenuColors get colors =>
      flutter_emoji_gif_picker.EmojiGifPickerPanel.colors;

  static setStyles(flutter_emoji_gif_picker.MenuStyles styles) {
    flutter_emoji_gif_picker.EmojiGifPickerPanel.setStyles(styles);
  }

  static flutter_emoji_gif_picker.MenuStyles get styles =>
      flutter_emoji_gif_picker.EmojiGifPickerPanel.styles;

  static set setGiphyApiKey(String giphyApiKey) {
    flutter_emoji_gif_picker.EmojiGifPickerPanel.setGiphyApiKey = giphyApiKey;
  }

  static void open(
      {flutter_emoji_gif_picker.MenuPosition? position,
      bool? openFromStack,
      bool viewGif = true,
      bool viewEmoji = true,
      required String id}) {
    flutter_emoji_gif_picker.EmojiGifPickerPanel.open(
        id: id,
        position: position,
        openFromStack: openFromStack,
        viewEmoji: viewEmoji,
        viewGif: viewGif);
  }

  static void close() {
    flutter_emoji_gif_picker.EmojiGifPickerPanel.close();
  }

  static bool get isOpened {
    return flutter_emoji_gif_picker.EmojiGifPickerPanel.isOpened;
  }

  static bool isMenuOpened(String id) {
    return flutter_emoji_gif_picker.EmojiGifPickerPanel.isMenuOpened(id);
  }

  static String? get currentMenuId {
    return flutter_emoji_gif_picker.EmojiGifPickerPanel.currentMenuId;
  }
}
