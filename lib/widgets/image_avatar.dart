import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {
  final double? size;
  final String? assetPath;
  final String? url;
  final double? borderWith;
  final ImageProvider<Object>? image;
  final Color? color, borderColor;
  final BoxFit? fit;
  const ImageAvatar(
      {Key? key,
      this.size,
      this.assetPath,
      this.url,
      this.image,
      this.color,
      this.fit,
      this.borderWith,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: borderWith != null
              ? Border.all(width: borderWith!, color: borderColor!)
              : null),
      child: ClipOval(
        child: image != null
            ? Image(
                width: size,
                height: size,
                image: image!,
                fit: fit,
              )
            : url != null
                ? ExtendedImage.network(
                    url!,
                    width: size ?? double.infinity,
                    height: size ?? double.infinity,
                    shape: BoxShape.circle,
                    fit: fit,
                  )
                : Image(
                    width: size,
                    height: size,
                    image: AssetImage(assetPath!),
                    fit: fit,
                  ),
      ),
    );
  }
}
