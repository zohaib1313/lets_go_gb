import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_blogs_controller.dart';

import '../../../drivers/common_widgets/home_screen_card.dart';
import '../../../drivers/utils/my_app_bar.dart';
import '../../../drivers/utils/utils.dart';

class AdminViewAllBlogsMobile extends GetView<AdminViewAllBlogsController> {
  const AdminViewAllBlogsMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<AdminViewAllBlogsController>(
            initState: (state) {},
            builder: (cc) {
              controller.temp.value;
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: [
                    myAppBar(title: 'Blogs', goBack: false, actions: [
                      Flexible(
                        child: MyAnimSearchBar(
                          width: MediaQuery.of(context).size.width,
                          onSuffixTap: () {
                            controller.searchController.clear();
                          },
                          closeSearchOnSuffixTap: true,
                          textController: controller.searchController,
                        ),
                      ),
                    ]),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        controller: ScrollController(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return HomeScreenCard(
                            text: "Skardu Valley",
                            height: context.height * 0.4,
                            btnText: "Explore",
                            image:
                                "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__480.jpg",
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
