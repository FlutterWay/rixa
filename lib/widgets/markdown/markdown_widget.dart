import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/themes/a11y-dark.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';
import 'package:markdown_widget/markdown_widget.dart' as markdown_widget;
import '../../rixa.dart';
import 'code_wrapper.dart';
import 'latex.dart';
import 'models/code_config.dart' as code_config;
import 'models/link_config.dart' as link_config;
import 'text_node.dart';
import 'video_node.dart';

class MarkdownWidget extends StatelessWidget {
  final LatexConfig? latexConfig;
  final code_config.CodeConfig codeConfig;
  final TextConfig textConfig;
  final ImageConfig? imageConfig;
  final String? assetPath;
  final Color? backgroundColor;
  final link_config.LinkConfig linkConfig;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry codePadding;
  final String? data;
  final bool isDarkTheme;
  final bool selectable, shrinkWrap;
  final Widget Function(Object)? errorBuilder;
  final Widget Function()? assetLoaderBuilder;
  MarkdownWidget({
    super.key,
    required this.isDarkTheme,
    this.data,
    this.latexConfig,
    this.imageConfig,
    this.padding,
    this.codePadding = EdgeInsets.zero,
    this.selectable = true,
    this.shrinkWrap = false,
    this.backgroundColor,
    this.assetPath,
    this.errorBuilder,
    this.assetLoaderBuilder,
    code_config.CodeConfig? codeConfig,
    TextConfig? textConfig,
    link_config.LinkConfig? linkConfig,
  })  : codeConfig = codeConfig ?? code_config.CodeConfig(),
        textConfig = textConfig ?? TextConfig(),
        linkConfig = linkConfig ?? link_config.LinkConfig();
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
        child: assetPath != null
            ? FutureBuilder(
                future: rootBundle.loadString(assetPath!),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return viewMarkdown(snapshot.data!);
                  } else if (snapshot.hasError) {
                    log(snapshot.error!.toString());
                    return errorBuilder != null
                        ? errorBuilder!(snapshot.error!)
                        : const SizedBox();
                  } else {
                    return assetLoaderBuilder != null
                        ? assetLoaderBuilder!()
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  }
                },
              )
            : viewMarkdown(data!));
  }

  Widget viewMarkdown(String data) {
    Color bg = isDarkTheme
        ? lighten(backgroundColor ?? Rixa.appColors.backgroundColor, .2)
        : darken(backgroundColor ?? Rixa.appColors.backgroundColor, .1);
    return markdown_widget.MarkdownWidget(
      data: data,
      padding: padding,
      selectable: selectable,
      shrinkWrap: shrinkWrap,
      markdownGeneratorConfig: markdown_widget.MarkdownGeneratorConfig(
        generators: [
          videoGeneratorWithTag,
          if (latexConfig != null)
            markdown_widget.SpanNodeGeneratorWithTag(
                tag: 'latex',
                generator: (e, config, visitor) => LatexNode(
                    e.attributes, e.textContent, config,
                    textStyle: latexConfig?.textStyle))
        ],
        inlineSyntaxList: [if (latexConfig != null) LatexSyntax()],
        textGenerator: (node, config, visitor) =>
            CustomTextNode(node.textContent, config, visitor),
      ),
      config: markdown_widget.MarkdownConfig(
        configs: [
          markdown_widget.PreConfig(
              textStyle: codeConfig.textStyle,
              padding: codeConfig.padding,
              decoration: codeConfig.decoration ??
                  BoxDecoration(
                    color: bg,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
              margin: codeConfig.margin,
              theme: isDarkTheme ? a11yDarkTheme : a11yLightTheme,
              wrapper: (child, code) => codeConfig.wrapper != null
                  ? Padding(
                      padding: codePadding,
                      child: codeConfig.wrapper!(child, code),
                    )
                  : Padding(
                      padding: codePadding,
                      child: CodeWrapperWidget(
                        text: code,
                        child: child,
                      ),
                    ),
              language: codeConfig.language),
          markdown_widget.PConfig(textStyle: textConfig.p),
          markdown_widget.H1Config(style: textConfig.h1),
          markdown_widget.H2Config(style: textConfig.h2),
          markdown_widget.H3Config(style: textConfig.h3),
          markdown_widget.H4Config(style: textConfig.h4),
          markdown_widget.H5Config(style: textConfig.h5),
          markdown_widget.H6Config(style: textConfig.h6),
          if (imageConfig != null)
            markdown_widget.ImgConfig(
              builder: imageConfig!.builder,
              errorBuilder: imageConfig!.errorBuilder,
            ),
          markdown_widget.LinkConfig(
              style: linkConfig.textStyle, onTap: linkConfig.onTap),
          markdown_widget.CodeConfig(
              style: TextStyle(
            color: codeConfig.textStyle.color,
            fontSize: codeConfig.textStyle.fontSize,
            fontWeight: codeConfig.textStyle.fontWeight,
            backgroundColor: bg,
          )),
        ],
      ),
    );
  }
}
