import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

Widget getPlayer(
        {String? filePath,
        String? url,
        String? asset,
        double? width,
        double? height}) =>
    VideoPlayerDesktop(
      filePath: filePath,
      url: url,
      asset: asset,
      width: width,
      height: height,
    );

class VideoPlayerDesktop extends StatefulWidget {
  final String? filePath, url, asset;
  final double? width, height;
  const VideoPlayerDesktop(
      {Key? key, this.filePath, this.url, this.asset, this.width, this.height})
      : super(key: key);

  @override
  State<VideoPlayerDesktop> createState() => _VideoPlayerDesktopState();
}

class _VideoPlayerDesktopState extends State<VideoPlayerDesktop> {
  late Player player;
  _VideoPlayerDesktopState() {
    player = Player(id: 69420);
    player.open(
      widget.filePath != null
          ? Media.file(File(widget.filePath!))
          : widget.url != null
              ? Media.network(widget.url)
              : Media.asset(widget.asset!),
      autoStart: false, // default
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Video(
        player: player,
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        fit: BoxFit.contain,
        volumeThumbColor: Colors.blue,
        volumeActiveColor: Colors.blue,
        showTimeLeft: true,
      ),
    );
  }
}
