import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';

class CropImage extends StatefulWidget {
  final Uint8List mainImage;
  final String? text;
  final String saveText, resetText, previewText, title;
  final void Function(Uint8List image)? onChanged;
  const CropImage(
      {super.key,
      required this.mainImage,
      this.text,
      this.onChanged,
      this.saveText = "Save",
      this.resetText = "Reset",
      this.previewText = "Preview",
      this.title = "Crop image as 1/1 ratio"});

  @override
  State<CropImage> createState() => _CropImageState();
}

class _CropImageState extends State<CropImage> {
  Uint8List? croppedImage;
  final _controller = CropController();
  AppSettings appSettings = Get.find<AppSettings>();
  AppFonts appFonts = Get.find<AppFonts>();
  AppColors appColors = Get.find<AppColors>();
  @override
  void dispose() {
    super.dispose();
  }

  double girth = 10, length = 30;
  int sayac = 0;
  bool isPreview = false, cropping = false;
  @override
  Widget build(BuildContext context) {
    double width =
        Rixa.properties.anyMobile ? appFonts.appWidth : appFonts.appWidth * 0.5;
    double height = width * 3 / 4;
    double croppedW = appFonts.appWidth * 0.3;
    double croppedH = croppedW * 3 / 4;
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          if (!Rixa.properties.anyMobile)
            Text(
              widget.title,
              style: appFonts.medium3(),
            ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: width,
                  height: height,
                  child: Container(
                    width: isPreview ? croppedW : width,
                    height: isPreview ? croppedH : height,
                    alignment: Alignment.center,
                    child: !isPreview
                        ? cropping
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Crop(
                                image: widget.mainImage,
                                aspectRatio: 1 / 1,
                                withCircleUi: false,
                                baseColor: Colors.grey[300]!,
                                controller: _controller,
                                cornerDotBuilder: (x, y) {
                                  sayac++;
                                  if (sayac == 5) sayac = 1;

                                  return Row(
                                    crossAxisAlignment: sayac == 1 || sayac == 2
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: sayac == 2 || sayac == 4
                                            ? length
                                            : girth,
                                        height: sayac == 2 || sayac == 4
                                            ? girth
                                            : length,
                                        color: Colors.black,
                                        child: const SizedBox(),
                                      ),
                                      Container(
                                        width: sayac == 2 || sayac == 4
                                            ? girth
                                            : length,
                                        height: sayac == 2 || sayac == 4
                                            ? length
                                            : girth,
                                        color: Colors.black,
                                        child: const SizedBox(),
                                      ),
                                    ],
                                  );
                                },
                                onCropped: (image) {
                                  setState(() {
                                    cropping = false;
                                    croppedImage = image;
                                    isPreview = true;
                                  });
                                })
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AdvancedAvatar(
                                  size: (Rixa.properties.anyMobile
                                      ? croppedW
                                      : croppedW / 2),
                                  statusColor: Colors.green,
                                  image: Image.memory(croppedImage!).image,
                                  foregroundDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: appColors.textColor,
                                      width: 5.0,
                                    ),
                                  )),
                              if (widget.text != null)
                                Text(
                                  widget.text!,
                                  style: appFonts.M(isBold: true),
                                )
                            ],
                          ),
                  ),
                ),
                Positioned(
                    right: 10,
                    bottom: 10,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            if (isPreview) {
                              croppedImage = null;
                              isPreview = false;
                              setState(() {});
                            } else {
                              setState(() {
                                cropping = true;
                              });
                              _controller.crop();
                            }
                          },
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              width: appFonts.appWidth *
                                  (Rixa.properties.anyMobile ? 0.2 : 0.1),
                              height: appFonts.appHeight * 0.06,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:
                                    !isPreview ? Colors.grey[700] : Colors.blue,
                              ),
                              child: Text(
                                isPreview
                                    ? widget.resetText
                                    : widget.previewText,
                                style: Rixa.properties.anyMobile
                                    ? appFonts.S(color: Colors.white)
                                    : appFonts.M(color: Colors.white),
                              )),
                        ),
                        if (isPreview)
                          TextButton(
                            onPressed: () {
                              if (widget.onChanged != null) {
                                widget.onChanged!(croppedImage!);
                              }
                              Navigator.pop(context);
                            },
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                width: appFonts.appWidth *
                                    (Rixa.properties.anyMobile ? 0.2 : 0.1),
                                height: appFonts.appHeight * 0.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.green[700],
                                ),
                                child: Text(
                                  widget.saveText,
                                  style: Rixa.properties.anyMobile
                                      ? appFonts.S(color: Colors.white)
                                      : appFonts.M(color: Colors.white),
                                )),
                          )
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void cropImage(
    {required BuildContext context,
    required Uint8List mainImage,
    String? text,
    String saveText = "Save",
    String resetText = "Reset",
    String previewText = "Preview",
    String title = "Crop image as 1/1 ratio",
    void Function(Uint8List image)? onChanged}) {
  Rixa.openDialog(
      child: CropImage(mainImage: mainImage, text: text, onChanged: onChanged),
      noAction: true,
      zeroPadding: Rixa.properties.anyMobile ? true : false,
      context: context);
}
