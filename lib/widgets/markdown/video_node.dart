import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/span_node.dart';
import 'package:markdown_widget/widget/widget_visitor.dart';
import 'package:rixa/widgets/rixa_player.dart';

class VideoNode extends SpanNode {
  final Map<String, String> attribute;

  VideoNode(this.attribute);

  @override
  InlineSpan build() {
    double? width;
    double? height;
    if (attribute['width'] != null) width = double.parse(attribute['width']!);
    if (attribute['height'] != null) {
      height = double.parse(attribute['height']!);
    }
    final link = attribute['src'] ?? '';
    return WidgetSpan(
        child: SizedBox(
      width: width,
      height: height,
      child: RixaPlayer.network(url: link),
    ));
  }
}

SpanNodeGeneratorWithTag videoGeneratorWithTag = SpanNodeGeneratorWithTag(
    tag: _videoTag, generator: (e, config, visitor) => VideoNode(e.attributes));

const _videoTag = 'video';

typedef VideoBuilder = Widget Function(
    String? url, Map<String, String> attributes);
typedef VideoWrapper = Widget Function(Widget video);

class VideoConfig implements InlineConfig {
  final double? aspectRatio;
  final bool autoPlay;
  final bool autoInitialize;
  final bool looping;

  final VideoBuilder? builder;

  const VideoConfig({
    this.aspectRatio,
    this.builder,
    this.autoPlay = false,
    this.autoInitialize = true,
    this.looping = false,
  });

  @nonVirtual
  @override
  String get tag => _videoTag;
}
