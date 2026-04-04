
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/components/image/shimmer_image_loader.dart';

import '../../../models/commonModels/chatMessageModels/chat_list_model.dart';
import '../../../theme/app_color.dart';
import '../../../theme/common_text_field_copy.dart';
import '../../components/customLoader/custom_loader.dart';
import '../../components/empty_widget.dart';
import '../../components/gradient_scafold.dart';
import '../../components/text/common_text.dart';
import 'innerController/chat_controller.dart';




class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  final _ctrl = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    _ctrl.fetchChatList();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonBackButton(),
                  CommonText(
                    text: "Message", fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.black500,
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

                      return InkWell(
                        onTap: () {
                          // _ctrl.fetchChatMessages(
                          //   userId: _ctrl.filteredList[index].participantId,
                          //   chatId: _ctrl.filteredList[index].chatId,
                          // );
                          // Get.to(()=> ChattingScreen(userId: _ctrl.filteredList[index].participantId,));
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
      decoration: BoxDecoration(
        color: AppColors.gray100
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
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

class GradientBorderAvatar extends StatelessWidget {
  final String avatarUrl;
  final double radius;
  final List<Color> gradientColors;
  final double borderWidth;

  const GradientBorderAvatar({
    super.key,
    required this.avatarUrl,
    this.radius = 26,
    this.gradientColors = const [Color(0xFF00C6FF), Color(0xFF0072FF)],
    this.borderWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientBorderPainter(
        gradientColors: gradientColors,
        borderWidth: borderWidth,
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth + 2),
        child: CircleAvatar(
          radius: radius.r,
          backgroundImage: NetworkImage(avatarUrl),
          backgroundColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final List<Color> gradientColors;
  final double borderWidth;

  _GradientBorderPainter({
    required this.gradientColors,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = SweepGradient(
      colors: gradientColors,
      startAngle: 0,
      endAngle: 3.14 * 2,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      size.center(Offset.zero),
      (size.width / 2) - borderWidth / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
