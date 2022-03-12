import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/common_widgets.dart';
import '../utils/styles.dart';

class ChooseImageWidget extends StatefulWidget {
  File? image;
  String? chooseTitle;

  dynamic onImageChoosed;

  ChooseImageWidget({required this.chooseTitle, this.onImageChoosed});

  @override
  _ChooseImageWidgetState createState() => _ChooseImageWidgetState();
}

class _ChooseImageWidgetState extends State<ChooseImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: DottedBorder(
        color: AppColor.greyColor,
        dashPattern: [10, 10],
        strokeWidth: 1,
        child: Container(
          padding: EdgeInsets.all(80.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgViewer(
                svgPath: 'assets/icons/ic_copy.svg',
                width: 200.w,
                height: 200.w,
              ),
              SizedBox(
                width: 50.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.chooseTitle ?? "",
                      style: AppTextStyles.textStyleNormalBodyMedium,
                    ),
                    Text(
                      widget.image?.path.split('/').last ?? "image file",
                      style: AppTextStyles.textStyleNormalBodyMedium
                          .copyWith(color: AppColor.greyColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50.w,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.image != null
                          ? Image.file(
                              widget.image!,
                              height: 80.h,
                              width: 1000.w,
                            )
                          : Button(
                              buttonText: "Choose",
                              textColor: AppColor.whiteColor,
                              onTap: () {
                                getFile();
                              },
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          '.png',
        ],
        allowMultiple: false);
    if (result != null) {
      File file = File(result.files.single.path!);
      widget.onImageChoosed(file);
      setState(() {
        widget.image = file;
      });
    } else {
      // User canceled the picker
    }
  }
}
