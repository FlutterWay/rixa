import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

Widget getPlayer(
        {String? filePath,
        String? url,
        String? asset,
        double? width,
        double? height}) =>
    VideoPlayerMobile(
      filePath: filePath,
      url: url,
      asset: asset,
      width: width,
      height: height,
    );

class VideoPlayerMobile extends StatefulWidget {
  final String? filePath, url, asset;
  final double? width, height;
  const VideoPlayerMobile(
      {Key? key, this.filePath, this.url, this.asset, this.width, this.height})
      : super(key: key);
  @override
  State<VideoPlayerMobile> createState() => _VideoPlayerMobileState();
}

class _VideoPlayerMobileState extends State<VideoPlayerMobile> {
  late FlickManager flickManager;
  _VideoPlayerMobileState() {
    flickManager = FlickManager(
        videoPlayerController: widget.filePath != null
            ? VideoPlayerController.file(File(widget.filePath!))
            : widget.url != null
                ? VideoPlayerController.network(widget.url!)
                : VideoPlayerController.asset(widget.asset!),
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
