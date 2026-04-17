import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../screens/home-screens/user_nav_bar.dart';

class BackHomeButton extends StatelessWidget {
  const BackHomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),


      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 214, 0, 1),
              Color.fromRGBO(255,149,0, 1),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(2), // border thickness
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(50, 30),
            backgroundColor: Colors.white, // white button
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // inner radius
            ),
          ),
          onPressed: () {
            // Get.to(()=> BookingAcceptedScreen());
            //Get.to(()=>HomeScreenOne());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),

            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Color.fromRGBO(255, 214, 0, 1),
                  Color.fromRGBO(255,149,0, 1),
                ],
              ).createShader(bounds),
              child: Text(
                'Back To Home',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 17
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ViewRidesButton extends StatelessWidget {
  const ViewRidesButton({
    super.key,
    required this.navbarController,
  });

  final UserNavBarController navbarController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ElevatedButton(
        onPressed: () {
          navbarController.tabIndex.value = 1;
          Get.to(()=>UserNavBar());

        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // important
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          //minimumSize: const Size(100, 50),
          minimumSize: const Size( 50, 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(255, 214, 0, 1),
                Color.fromRGBO(255,149,0, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
            child: const Text(
              'View My Bookings',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                //fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}