import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/pages/user_blog_detail_page.dart';

import '../../drivers/common_widgets/home_screen_card.dart';
import '../controllers/user_view_all_blogs_controller.dart';

class UserViewAllBlogsPage extends GetView<UserViewAllBlogsController> {
  const UserViewAllBlogsPage({Key? key}) : super(key: key);
  static const id = '/UserViewAllBlogsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Places to visit', goBack: true),
      body: SafeArea(
        child: GetX<UserViewAllBlogsController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return Padding(
                padding: EdgeInsets.all(10.h),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(UserViewBlogDetailsPage.id);
                        },
                        child: HomeScreenCard(
                          text: "Skardu Valley",
                          btnText: "Explore",
                          image:
                              "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__480.jpg",
                        ),
                      );
                    }),
              );
              /*SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child:
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebasePathNodes.appConstants)
                          .doc('PrivacyPolicy')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoadingWidget();
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (snapshot.data!.data() == null) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        var s = snapshot.data!.data() as Map<String, dynamic>;
                        return SimpleRichText(
                          s['PrivacyPolicy'],
                          style: AppTextStyles.textStyleNormalBodySmall,
                        );
                      },
                    ),
                  ));*/
            }),
      ),
    );
  }
}
