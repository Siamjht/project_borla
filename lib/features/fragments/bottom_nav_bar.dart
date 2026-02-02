import 'package:flutter/material.dart';


Stack bttmNavBar(bttmNavBarIndex, onItemTapped, context) {

  return Stack(

    children: [
      BottomNavigationBar(

        items: [

          BottomNavigationBarItem(

            //icon: Icon(Icons.list_alt),
            icon: bttmNavBarIndex == 0 ?
                      Image.asset('assets/images/home_two.png', scale: 3.5,)
                      : Image.asset('assets/images/home_one.png', scale: 3.5,),
            label: 'Home',

          ),

          BottomNavigationBarItem(

             // icon: onItemTapped == 1 ? Image.asset('assets/images/wallet.png') : Image.asset('assets/images/home.png') ,
              icon: bttmNavBarIndex == 1 ? Image.asset('assets/images/wallet_two.png', scale: 3.5,) : Image.asset('assets/images/wallet_one.png', scale: 3.5,)  ,
              label: 'Activity'

          ),

          BottomNavigationBarItem(

              icon: bttmNavBarIndex == 2 ? Image.asset('assets/images/notify_two.png', scale: 3.5,) : Image.asset('assets/images/notify_one.png', scale: 3.5,),
              label: 'Notification'

          ),

          BottomNavigationBarItem(

              icon: bttmNavBarIndex == 3 ? Image.asset('assets/images/user_two.png', scale: 3.5,) : Image.asset('assets/images/user_one.png', scale: 3.5,),
              label: 'Profile'

          ),



        ],
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: bttmNavBarIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,

      ),

      if(bttmNavBarIndex==0)
        Positioned(
        top: 0,
        left: MediaQuery.of(context).size.width / 4 * bttmNavBarIndex + 20,
       // left: 19,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          height: 3,
          //width: MediaQuery.of(context).size.width / 4,
          width: 64,
          color: Colors.amber,
        ),
      )
      else if(bttmNavBarIndex==1)
        Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width / 4 * bttmNavBarIndex + 20,
          //left: 122,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            height: 3,
            //width: MediaQuery.of(context).size.width / 4,
            width: 64,
            color: Colors.amber,
          ),
        )
      else if(bttmNavBarIndex==2)
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 4 * bttmNavBarIndex + 20,
            //left: 224,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: 3,
              //width: MediaQuery.of(context).size.width / 4,
              width: 64,
              color: Colors.amber,
            ),
          )
        else
            Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width / 4 * bttmNavBarIndex + 20,
              //left: 328,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: 3,
                //width: MediaQuery.of(context).size.width / 4,
                width: 64,
                color: Colors.amber,
              ),
            )
    ],
  );

}