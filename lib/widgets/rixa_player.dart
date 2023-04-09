import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import 'video_player_desktop.dart';
import 'video_player_mobile.dart';

class RixaPlayer extends StatelessWidget {
  final String path;
  final double? width, height;
  const RixaPlayer({
    Key? key,
    required this.path,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Rixa.properties.isDesktop
        ? VideoPlayerDesktop(path: path, width: width, height: height)
        : VideoPlayerMobile(path: path, width: width, height: height);
  }
}
