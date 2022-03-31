import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/chat_model.dart';

import '../../utils/common_widgets.dart';
import '../../utils/styles.dart';
import '../controllers/driver_chat_with_user_controller.dart';

class ChatScreen extends GetView<DriverChatWithUserController> {
  static const id = "/ChatScreenUser";

  const ChatScreen({Key? key}) : super(key: key);

  /*

  firebase stream builder will be used here to listen realtime changes

*/

  @override
  Widget build(BuildContext context) {
    return GetX<DriverChatWithUserController>(initState: (state) {
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', true));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', true));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', true));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', true));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', true));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', true));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', true));
      controller.listOfChat.add(ChatModel('Hello one', false));
      controller.listOfChat.add(ChatModel('Hello one', true));
      controller.listOfChat.add(ChatModel('Hello one', false));
    }, builder: (staex) {
      controller.temp.value;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.whiteColor,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: AppColor.blackColor),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        Image.asset("assets/images/place_your_image.png").image,
                  ),
                  SizedBox(
                    width: 35.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Zohaib",
                          style: AppTextStyles.textStyleBoldBodySmall),
                      Text("Active Now",
                          style: AppTextStyles.textStyleBoldBodySmall.copyWith(
                              color: AppColor.greenColor,
                              fontWeight: FontWeight.normal))
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(50.w),
                    child: const SvgViewer(
                        svgPath: "assets/icons/ic_video_call.svg"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(50.w),
                    child: const SvgViewer(
                        svgPath: "assets/icons/ic_audio_call.svg"),
                  )
                ],
              )
            ],
          ),
        ),
        backgroundColor: AppColor.alphaGrey,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  //  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(
                    left: 50.w,
                    right: 50.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.alphaGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      /// firebase stream builder will be used here to listen realtime changes
                      itemCount: controller.listOfChat.length,
                      shrinkWrap: true,
                      itemBuilder: (contxt, index) {
                        if (controller.listOfChat[index].isSending) {
                          return getChatBubble(BubbleType.sendBubble,
                              controller.listOfChat[index].message, context);
                        } else {
                          return getChatBubble(BubbleType.receiverBubble,
                              controller.listOfChat[index].message, context);
                        }
                      },
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                color: AppColor.whiteColor,
                child: Row(
                  children: [
                    const Expanded(
                      child: SvgViewer(
                        height: 30,
                        width: 30,
                        svgPath: "assets/icons/ic_add.svg",
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Enter your message',
                          hintStyle: AppTextStyles.textStyleNormalBodyXSmall,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          fillColor: AppColor.alphaGrey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          /*Provider.of<AllJobsViewModel>(myContext!,
                                    listen: false)
                                .getAllJobs(completion: (List<Jobs> jobs) {
                              Navigator.of(myContext!).push(MaterialPageRoute(
                                  builder: (context) => JobPostedScreen()));
                            });*/

                          sendMessage();
                        },
                        child: const SvgViewer(
                          height: 30,
                          width: 30,
                          svgPath: "assets/icons/ic_send_message.svg",
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  getChatBubble(BubbleType bubbleType, String message, BuildContext context) {
    if (bubbleType == BubbleType.sendBubble) {
      return ChatBubble(
        clipper: ChatBubbleClipper3(type: bubbleType),
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 20),
        backGroundColor: AppColor.chatSendColor.withOpacity(0.34),
        shadowColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    } else {
      return ChatBubble(
        clipper: ChatBubbleClipper3(type: BubbleType.receiverBubble),
        backGroundColor: AppColor.chatReceiveColor.withOpacity(0.34),
        margin: const EdgeInsets.only(top: 20),
        shadowColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }

  void sendMessage() {}
}
