import 'package:flutter/material.dart';

class ImageConfig {
  ///use [builder] to return a custom image
  final Widget Function(String url, Map<String, String> attributes)? builder;

  ///use [errorBuilder] to return a custom error image
  final Widget Function(String url, String alt, Object error)? errorBuilder;

  const ImageConfig({this.builder, this.errorBuilder});
}
