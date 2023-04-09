import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

class VideoPlayerDesktop extends StatefulWidget {
  final String path;
  final double? width, height;
  const VideoPlayerDesktop(
      {Key? key, required this.path, this.width, this.height})
      : super(key: key);

  @override
  State<VideoPlayerDesktop> createState() => _VideoPlayerDesktopState();
}

class _VideoPlayerDesktopState extends State<VideoPlayerDesktop> {
  late Player player;
  _VideoPlayerDesktopState() {
    player = Player(id: 69420);
    player.open(
      Media.file(File(widget.path)),
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
