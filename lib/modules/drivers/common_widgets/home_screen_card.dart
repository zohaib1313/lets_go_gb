import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

class BlogViewItemCard extends StatelessWidget {
  final String? image;
  final String? name;

  bool? showBottomArrow = true;
  double? width;
  double? height;
  Function? onDelete;

  BlogViewItemCard(
      {Key? key,
      this.image,
      this.showBottomArrow = true,
      this.name,
      this.width,
      this.height,
      this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Card(
        elevation: 1,
        child: SizedBox(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 220.h,
          //column as child
          child: Stack(
            children: [
              NetworkPlainImage(
                width: width,
                height: height,
                url: image ??
                    "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__480.jpg",
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: width ?? MediaQuery.of(context).size.width,
                  color: AppColor.blackColor.withOpacity(0.5),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          name ?? '-',
                          style: AppTextStyles.textStyleBoldBodyMedium
                              .copyWith(color: AppColor.whiteColor),
                        ),
                      ),
                      if ((showBottomArrow ?? true))
                        const Icon(
                          Icons.arrow_forward,
                          color: AppColor.whiteColor,
                        )
                    ],
                  ),
                ),
              ),
              if (onDelete != null)
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<int>(
                    color: AppColor.whiteColor,
                    onSelected: (item) => {onDelete!()},
                    itemBuilder: (context) => [
                      const PopupMenuItem<int>(value: 1, child: Text('Delete')),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
