import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';

class UserAuthController extends GetxController{

  final RxString userEmail = ''.obs;

  final  RxString userPhone = ''.obs ;

  final  RxString userPass = ''.obs ;

  final  RxString userNewPass = ''.obs ;

  final  RxString userConfirmPass = ''.obs ;

  final  RxInt userOtp = 0.obs ;

  final RxBool keepLogin = false.obs ;

  final RxBool googleLogin = false.obs ;

  final RxBool appleLogin = false.obs ;

  TextEditingController emailController = TextEditingController();

  // login controllers
  late final PhoneController phoneController;
  final TextEditingController passController = TextEditingController();

  //set password controllers

  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  // register screen controller

  late PhoneController registerPhoneController = PhoneController();

  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerLocationController = TextEditingController();
  TextEditingController registerPassController = TextEditingController();
  TextEditingController registerConfirmPassController = TextEditingController();


}