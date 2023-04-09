import 'package:boxicons/boxicons.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';

import '../functions/functions.dart';
import 'on_hover.dart';

class ProfileAvatar extends StatelessWidget {
  final String? url;
  final String? profileName;
  final double? size;
  final double? iconSize;
  final double borderWith;
  final bool noAction;
  final Widget? child;
  final ImageProvider<Object>? image, defaultImage;
  final bool isEdit;
  final void Function()? onClick;
  ProfileAvatar(
      {Key? key,
      this.url,
      this.profileName,
      this.onClick,
      this.borderWith = 5,
      this.isEdit = true,
      this.image,
      this.noAction = false,
      this.defaultImage,
      this.iconSize,
      this.size})
      : child = profileName != null
            ? Text(
                getShortOfName(profileName),
                style: Get.find<AppFonts>().M(color: Colors.white),
              )
            : null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return !noAction
        ? OnHover(
            doTransform: false,
            builder: (isHovered) {
              return SizedBox(
                width: size ?? double.infinity,
                height: size ?? double.infinity,
                child: Stack(
                  children: [
                    TextButton(
                      onPressed: () {
                        onClick!();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: viewImage(isHovered),
                    ),
                    if (isHovered)
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          onClick!();
                        },
                        child: Center(
                          child: Icon(
                            isEdit ? Icons.edit : Boxicons.bx_show,
                            color: Colors.black,
                            size: size != null ? (size! / 3) : iconSize ?? 20,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            })
        : SizedBox(
            width: size ?? double.infinity,
            height: size ?? double.infinity,
            child: viewImage(false));
  }

  Widget viewImage(bool isHovered) {
    return Opacity(
      opacity: isHovered ? 0.5 : 1,
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: borderWith, color: Colors.blue)),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: image != null
                    ? Image(
                        width: size,
                        height: size,
                        image: image!,
                        fit: BoxFit.cover,
                      )
                    : url != null
                        ? ExtendedImage.network(
                            url!,
                            width: size ?? double.infinity,
                            height: size ?? double.infinity,
                            shape: BoxShape.circle,
                            fit: BoxFit.cover,
                            //cancelToken: cancellationToken,
                          )
                        : child ??
                            (defaultImage != null
                                ? Image(
                                    width: size,
                                    height: size,
                                    image: defaultImage!,
                                    fit: BoxFit.cover,
                                  )
                                : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
