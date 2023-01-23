import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transation/screens/add_transaction.dart';


import '../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  // این چند تا get ها همگی به ورت اجباری و پیشفرض به ویجت سرچ ابار انیمیشن اضافه میشه

  get textEditingController => TextEditingController();

  get secondaryButtonWidget => Icon(Icons.close);

  get trailingWidget =>  Icon(Icons.search);

  get isOriginalAnimation => false;

  get buttonWidget => Icon(Icons.search);

  //******************************

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
        FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTransaction()));
          },
          backgroundColor: kPurpleColor,
          elevation: 0,
          child: const Icon(Icons.add),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: HeaderWidget(textEditingController: textEditingController, isOriginalAnimation: isOriginalAnimation, trailingWidget: trailingWidget, secondaryButtonWidget: secondaryButtonWidget, buttonWidget: buttonWidget),
              ),
              Spacer(),
              EmptyWidget(),
              Spacer(),
            ],
          ),

        ),
      ),
    );
  }
}

//Header Widget
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.textEditingController,
    required this.isOriginalAnimation,
    required this.trailingWidget,
    required this.secondaryButtonWidget,
    required this.buttonWidget,
  }) : super(key: key);

  final  textEditingController;
  final  isOriginalAnimation;
  final  trailingWidget;
  final  secondaryButtonWidget;
  final  buttonWidget;

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Expanded(
          child: SearchBarAnimation(
            textEditingController: textEditingController,
            isOriginalAnimation: isOriginalAnimation,
            trailingWidget: trailingWidget,
            secondaryButtonWidget: secondaryButtonWidget,
            buttonWidget: buttonWidget,
            hintText: 'جست و جو کنید',
          ),
        ),

        const SizedBox(width: 20.0),
        const Text('تراکنش ها'),
        // Spacer(),
      ],
    );
  }
}


// Empty Widget
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SvgPicture.asset('assets/images/empty.svg',),
        Text('تراکنشی وجود ندارد'),
      ],
    );
  }
}
