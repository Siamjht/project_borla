
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  final messages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    messages.addAll([
      {
        'text': 'Hello Theo, good morning!\nPlease let me know later if you are going',
        'time': '09:41',
        'isMe': false,
      },
      {
        'text': 'Hello, good morning Andrew',
        'time': '09:41',
        'isMe': true,
      },
      {
        'text': 'Okay, I\'ll go at 10 o\'clock sharp.\nI\'ll tell you later',
        'time': '09:41',
        'isMe': true,
      },
      {
        'text':
        'Great! I will be waiting for you in front of Book Library. You can contact me as soon as possible when you ready',
        'time': '09:41',
        'isMe': false,
      },
      {
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6Oscs7FPShs1F246LuU35bGMlOT-cnIANwQ&s'
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUNM4eK5cXKCpnA9kiFTTrblB2BuQsvmVqEw&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuOOsWYxEhV4Z6LR0FJ8CJvjXN58chOsFptA&s',
        ],
        'time': '09:41',
        'isMe': false,
      },
      {
        'text': 'Sure stay connected',
        'time': '09:41',
        'isMe': true,
      },
    ]);
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messages.add({
      'text': messageController.text.trim(),
      'time': 'Now',
      'isMe': true,
    });

    messageController.clear();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      messages.add({
        'images': [image.path],
        'time': 'Now',
        'isMe': true,
      });
    }
  }


  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');

    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Dialer error: $e');
    }
  }

}