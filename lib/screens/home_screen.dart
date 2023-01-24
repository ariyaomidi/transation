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

  get secondaryButtonWidget => const Icon(Icons.close);

  get trailingWidget => const Icon(Icons.search);

  get isOriginalAnimation => false;

  get buttonWidget => const Icon(Icons.search);

  //******************************

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTransaction()));
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
                child: HeaderWidget(
                    textEditingController: textEditingController,
                    isOriginalAnimation: isOriginalAnimation,
                    trailingWidget: trailingWidget,
                    secondaryButtonWidget: secondaryButtonWidget,
                    buttonWidget: buttonWidget),
              ),
              // Spacer(),
              // EmptyWidget(),

              ListView.builder(itemBuilder: (context, index) {
                return const MyListTileWidget();
              },itemCount: 10,),


              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// my List tile widget

class MyListTileWidget extends StatelessWidget {
  const MyListTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red),
            child: const Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
          ),
          const Spacer(flex: 1),
          const Text('Gym'),
          const Spacer(flex: 30),
          Column(
            children: [
              Row(
                children: const [
                  Text('تومان'),
                  SizedBox(
                    width: 5,
                  ),
                  Text('10,000'),
                ],
              ),
              const Text('1401/02/03')
            ],
          )
        ],
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

  final textEditingController;
  final isOriginalAnimation;
  final trailingWidget;
  final secondaryButtonWidget;
  final buttonWidget;

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
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/empty.svg',
        ),
        const Text('تراکنشی وجود ندارد'),
      ],
    );
  }
}
