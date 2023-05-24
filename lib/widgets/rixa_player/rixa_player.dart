// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import 'video_player.dart' //
    if (dart.library.io) 'video_player_desktop.dart'
    if (dart.library.html) 'video_player_mobile.dart';

class RixaPlayer extends StatelessWidget {
  final String? filePath, url, asset;
  final double? width, height;
  const RixaPlayer.file({
    Key? key,
    required this.filePath,
    this.width,
    this.height,
  })  : url = null,
        asset = null,
        super(key: key);
  const RixaPlayer.network({
    Key? key,
    required this.url,
    this.width,
    this.height,
  })  : filePath = null,
        asset = null,
        super(key: key);
  const RixaPlayer.asset({
    Key? key,
    required this.asset,
    this.width,
    this.height,
  })  : filePath = null,
        url = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlayer(
        filePath: filePath,
        url: url,
        asset: asset,
        width: width,
        height: height);
  }
}
