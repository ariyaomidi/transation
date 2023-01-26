import 'package:flutter/material.dart';

import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transation/screens/add_transaction.dart';

import '../constant.dart';
import '../models/money.dart';

class HomeScreen extends StatefulWidget {
// بخاطر دسترسی سریع از کلمه کلیدی استاتیک استفاده میکنیم
// ولی اگه از کلمه کلیدی استاتیک استفاده نکنیم باید جهت دسترسی به متغیر مانی از شبیه زیر استفاده کنیم
// Homescreen().money[index].title
//ولی با کلمه کلیدی استاتیک به صورت زیر مینویسیم
//Homescreen.Money[index].title
//تفاوت را دقت کنیم
  static List<Money> money = [];

  static bool isEditing = false;

  static int indexEditing = 0;

  const HomeScreen({super.key});

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
        floatingActionButton: fab(),
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



              Expanded(
                child: HomeScreen.money.isEmpty?
                Column(
                  children:const [
                    Spacer(),
                    EmptyWidget(),
                    Spacer(),
                  ],
                ):ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: MyListTileWidget(index: index),

                      //Edite
                      onTap: (){
                        HomeScreen.isEditing = true;

                        AddTransaction.titleController.text=HomeScreen.money[index].title;
                        AddTransaction.priceController.text=HomeScreen.money[index].price;
                        AddTransaction.groupId = HomeScreen.money[index].isReceived?1:2;

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        const AddTransaction(),),).then((value) {
                          setState(() {
                            print('فراخوانی متد ست استیت بعد از ویرایش');
                          });
                        });;
                      },

                      //Delete
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title:const Text(
                              'آیا از حذف این مورد مطمئن هستید؟',
                              style: TextStyle(fontSize: 20),
                            ),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('خیر')),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      HomeScreen.money.removeAt(index);
                                    });
                                    Navigator.pop(context);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Row(
                                          children: [
                                            Text('حذف شد'),
                                            Spacer(),
                                            TextButton(
                                                onPressed: () {},
                                                child: const Text('برگرداندن'))
                                          ],
                                        )));
                                  },
                                  child: const Text('بله')),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  itemCount: HomeScreen.money.length,
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget fab() {
    return FloatingActionButton(
      onPressed: () {
        HomeScreen.isEditing = false;
        AddTransaction.groupId = 0;
        AddTransaction.priceController.text = '';
        AddTransaction.titleController.text = '';
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTransaction()))
            .then((value) {
          setState(() {
            print('فراخوانی متد ست استیت بعد از اضافه کردن تراکنش');
          });
        });
      },
      backgroundColor: kPurpleColor,
      elevation: 0,
      child: const Icon(Icons.add),
    );
  }

// این دوتا متود باز نویسی شده جهت عمودی کردن صفحه برنامه که حتما باید کلاس سرویسز های فایل دارت هم باید امپورت کرد
// @override
// void initState() {
//   super.initState();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.landscapeRight,
//     DeviceOrientation.landscapeLeft
//   ]);
// }
//
//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     super.dispose();
//   }

}

// my List tile widget

class MyListTileWidget extends StatelessWidget {
  final int index;

  const MyListTileWidget({super.key, required this.index});

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
                color: HomeScreen.money[index].isReceived
                    ? kGreenColor
                    : kRedColor),
            child: Icon(
              HomeScreen.money[index].isReceived
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
          const Spacer(flex: 1),
          Text(HomeScreen.money[index].title),
          const Spacer(flex: 30),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'تومان',
                    style: TextStyle(
                        color: HomeScreen.money[index].isReceived
                            ? kGreenColor
                            : kRedColor),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(HomeScreen.money[index].isReceived ? '+' : '-',
                      style: TextStyle(
                          color: HomeScreen.money[index].isReceived
                              ? kGreenColor
                              : kRedColor)),
                  Text(HomeScreen.money[index].price,
                      style: TextStyle(
                          color: HomeScreen.money[index].isReceived
                              ? kGreenColor
                              : kRedColor)),
                ],
              ),
              Text(HomeScreen.money[index].date)
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
