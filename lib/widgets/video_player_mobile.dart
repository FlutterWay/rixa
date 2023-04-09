import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerMobile extends StatefulWidget {
  final String path;
  final double? width, height;
  const VideoPlayerMobile(
      {Key? key, required this.path, this.width, this.height})
      : super(key: key);

  @override
  State<VideoPlayerMobile> createState() => _VideoPlayerMobileState();
}

class _VideoPlayerMobileState extends State<VideoPlayerMobile> {
  late FlickManager flickManager;
  _VideoPlayerMobileState() {
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.file(File(widget.path)),
        autoPlay: false);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        child: FlickVideoPlayer(flickManager: flickManager),
      ),
    );
  }
}
