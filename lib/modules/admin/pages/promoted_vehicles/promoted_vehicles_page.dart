import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/utils/Utils.dart';

import '../../../drivers/common_widgets/home_screen_card.dart';
import '../../../drivers/utils/utils.dart';
import '../../controller/promoted_vehicles_controller.dart';
import '../../models/promoted_images_model.dart';

class PromotedAdsPage extends GetView<PromotedAdsController> {
  const PromotedAdsPage({Key? key}) : super(key: key);
  static const id = '/PromotedAdsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.add),
        backgroundColor: AppColor.greenColor,
        onPressed: () {
          if (kIsWeb) {
            AppUtils.pickWebImage(onCompleteWebUnit8List: (unit8ListImage) {
              controller.uploadImageWeb(unit8ListImage);
            });
          } else {
            AppUtils.showPicker(
                context: context,
                onComplete: (file) {
                  controller.uploadImageFile(file);
                });
          }
        },
      ),
      appBar: myAppBar(title: 'Promotion Ads', goBack: false, actions: []),
      body: SafeArea(
        child: GetX<PromotedAdsController>(initState: (state) {
          controller.loadPromotions();
        }, builder: (context) {
          return Stack(
            children: [
              controller.promotionAdsList.isEmpty
                  ? Center(
                      child: Text(
                        "No Ads Found",
                        style: AppTextStyles.textStyleBoldSubTitleLarge,
                      ),
                    )
                  : GridView.builder(
                      itemCount: controller.promotionAdsList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6.0,
                              mainAxisSpacing: 6.0),
                      physics: const BouncingScrollPhysics(),
                      controller: ScrollController(),
                      itemBuilder: (context, index) {
                        return rowItem(
                            model: controller.promotionAdsList[index]!);
                      }),
              if (controller.isLoading.isTrue) LoadingWidget()
            ],
          );
        }),
      ),
    );
  }

  Widget rowItem({required Promotions model}) {
    return BlogViewItemCard(
      onDelete: () {
        controller.deleteItem(model: model);
      },
      name: model.name ?? '',
      showBottomArrow: false,
      image: model.imageUrl ??
          'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__480.jpg',
    );
  }
}
