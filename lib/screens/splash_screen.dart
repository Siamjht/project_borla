import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoute.onboard1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        alignment: Alignment.center,

        decoration: BoxDecoration(

          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(64),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          gradient: const LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter ,
            colors: [
              Color(0xFFFFF8E8),
              Colors.white,
              // Color.fromRGBO(255, 246, 217, 1),
              // Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
        ),



        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),

            Transform.translate(
              offset: const Offset(0, 0),
              child: Image.asset(
                'assets/images/logo_2.png',
                width: 180,
              ),
            ),
          ],
        )



      ),



    );
  }
}
