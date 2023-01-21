import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  Widget body = HomeScreen();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [Icons.home, Icons.info],
        activeIndex: currentIndex,
        gapLocation: GapLocation.center,
        onTap: (index) {

          if(index == 0){
            body=HomeScreen();
          }
          else{
            body=const Center(child:Text('info'));
          }


          setState(() {
            currentIndex = index;
          });
        },

        inactiveColor: Colors.black45,

        notchSmoothness: NotchSmoothness.smoothEdge,
      ),

      body: body,
    );
  }
}
