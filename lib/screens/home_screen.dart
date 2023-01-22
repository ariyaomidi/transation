import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  get textEditingController => TextEditingController();

  get secondaryButtonWidget => Icon(Icons.close);

  get trailingWidget =>  Icon(Icons.search);

  get isOriginalAnimation => false;

  get buttonWidget => Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: kPurpleColor,
          elevation: 0,
          child: const Icon(Icons.add),
        ),
        body: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(

              children: [
                Expanded(
                  child: SearchBarAnimation(textEditingController: textEditingController,
                      isOriginalAnimation: isOriginalAnimation,
                      trailingWidget: trailingWidget,
                      secondaryButtonWidget: secondaryButtonWidget,
                      buttonWidget: buttonWidget),
                ),
                SizedBox(width: 20.0),
                Text('تراکنش ها'),
                Spacer(),
                SvgPicture.asset('assets/images/empty.svg')

              ],
            ),
          ),
        ),
      ),
    );
  }
}
