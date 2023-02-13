import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rixa/rixa.dart';
import 'video_player_desktop.dart';
import 'video_player_mobile.dart';

class RixaPlayer extends StatelessWidget {
  String path;
  double? width, height;
  RixaPlayer({Key? key, required this.path, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Rixa.properties.isDesktop
        ? VideoPlayerDesktop(path: path, width: width, height: height)
        : VideoPlayerMobile(path: path, width: width, height: height);
  }
}
