
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/helpers/prefs_helper.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/components/image/shimmer_image_loader.dart';
import 'package:project_borla/screens/chat-screen/user_chat_screen.dart';
import 'package:project_borla/theme/gradient_scaffold_copy.dart';

import '../../../models/commonModels/chatMessageModels/chat_list_model.dart';
import '../../../theme/app_color.dart';
import '../../components/customLoader/custom_loader.dart';
import '../../components/empty_widget.dart';
import '../../components/gradient_scafold.dart';
import '../../components/text/common_text.dart';
import 'chatting_screen.dart';
import 'innerController/chat_controller.dart';




class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  final _ctrl = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    _ctrl.fetchChatList();
  }

  @override
  Widget build(BuildContext context) {
    if(PrefsHelper.myRole == "user"){
      return UserGradientScaffold(
        child: _buildChatList(),
      );
    }else{
      return GradientScaffold(
        child: _buildChatList(),
      );
    }
  }

  SafeArea _buildChatList() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonBackButton(),
                CommonText(
                  text: "message".tr, fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.black500,
                ),
                20.horizontalSpace
              ],
            ),
            16.verticalSpace, // slightly more breathing room

            Expanded(
              child: Obx(() {
                if (_ctrl.isChatListLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_ctrl.chatList.isEmpty) {
                  return const EmptyStateWidget(
                    message: 'No chats yet',
                    icon: Icon(Icons.chat_bubble_outline_rounded,
                        size: 60, color: AppColors.gray200),
                  );
                }

                return ListView.builder(
                  controller: _ctrl.chatListScrollController, // ✅
                  itemCount: _ctrl.chatList.length + (_ctrl.hasMoreChats.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    // ── Load More Spinner ──
                    if (index == _ctrl.chatList.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CustomLoader(size: 24),
                        ),
                      );
                    }
                    if(_ctrl.chatList[index].participantRole == "admin"){
                      return SizedBox.shrink();
                    }

                    return InkWell(
                      onTap: () {
                        final person = _ctrl.chatList[index];
                        if(PrefsHelper.myRole == 'user'){
                          Get.to(() => UserChattingScreen(
                            bookingId: person.bookingId,
                            participantName: person.participantName,
                          ));
                        }else{
                          Get.to(() => ChattingScreen(
                            bookingId: person.bookingId,
                            participantName: person.participantName,
                          ));
                        }
                      },
                      child: ChatListItem(person: _ctrl.chatList[index]),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// Chat List Item Widget
class ChatListItem extends StatelessWidget {
  final CustomChatListItem person;

  const ChatListItem({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: PrefsHelper.myRole == "user"? AppColors.green20 : AppColors.orange20,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                ShimmerImageLoader(
                  borderRadius: 50,
                    url: person.participantProfile,
                    width: 50,
                    height: 50
                ),

                12.horizontalSpace,

                // Name, message & time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name + Time row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: person.participantName,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black500,
                          ),
                          CommonText(
                            textAlign: TextAlign.left,
                            text: person.time,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.green500,
                          ),
                        ],
                      ),

                      5.verticalSpace,

                      // Message + unread badge row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CommonText(
                              text: person.lastMessage,
                              fontSize: 12,
                              fontWeight: person.unreadCount > 0? FontWeight.w600 : FontWeight.w400,
                              color: person.unreadCount > 0? AppColors.gray500:AppColors.gray400,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[200],
            indent: 16.w,
            endIndent: 16.w,
          ),
        ],
      ),
    );
  }
}
