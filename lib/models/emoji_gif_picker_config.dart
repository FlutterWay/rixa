import 'package:flutter_emoji_gif_picker/flutter_emoji_gif_picker.dart'
    as flutter_emoji_gif_picker;

import 'mode.dart';

class EmojiGifPickerConfig {
  flutter_emoji_gif_picker.MenuSizes? sizes;
  flutter_emoji_gif_picker.MenuTexts? texts;
  flutter_emoji_gif_picker.MenuColors? colors;
  flutter_emoji_gif_picker.MenuStyles? styles;
  String? giphyApiKey;
  Mode mode;

  EmojiGifPickerConfig(
      {required this.giphyApiKey,
      this.sizes,
      this.texts,
      this.colors,
      this.styles,
      this.mode = Mode.light});
}
