import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:transation/main.dart';
import 'package:transation/screens/add_transaction.dart';

import '../constant.dart';
import '../models/money.dart';

class HomeScreen extends StatefulWidget {
  static List<Money> money = [];

  static bool isEditing = false;

  static int indexEditing = 0;

  static int idEdit = 0;

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<Money> hiveBox = Hive.box<Money>('MoneyBox');
  TextEditingController searchController = TextEditingController();
  bool isSearch =false;


  // get onFieldSubmitted => (String text) {
  //   List<Money> result = hiveBox.values
  //       .where((element) =>
  //   element.title.contains(text) ||
  //       element.date.contains(text))
  //       .toList();
  //   HomeScreen.money.clear();
  //   setState(() {
  //     for (var value in result) {
  //       HomeScreen.money.add(value);
  //     }});
  // };

  //******************************

  @override
  void initState() {
    MyApp.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: fab(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:myAppBar()
              ),
              Expanded(
                  child: HomeScreen.money.isEmpty
                      ? Column(
                          children: const [
                            Spacer(),
                            EmptyWidget(),
                            Spacer(),
                          ],
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: MyListTileWidget(index: index),

                              //Edite
                              onTap: () {
                                HomeScreen.isEditing = true;
                                HomeScreen.idEdit = HomeScreen.money[index].id;
                                HomeScreen.indexEditing = index;

                                AddTransaction.setDate=
                                    HomeScreen.money[index].date;
                                AddTransaction.titleController.text =
                                    HomeScreen.money[index].title;
                                AddTransaction.priceController.text =
                                    HomeScreen.money[index].price;
                                AddTransaction.groupId =
                                    HomeScreen.money[index].isReceived ? 1 : 2;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddTransaction(),
                                  ),
                                ).then((value) {
                                  setState(() {
                                    MyApp.getData();
                                    print(
                                        'فراخوانی متد ست استیت بعد از ویرایش');
                                  });
                                });
                              },

                              //Delete
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'آیا از حذف این مورد مطمئن هستید؟',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    actionsAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('خیر')),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              hiveBox.deleteAt(index);
                                              MyApp.getData();
                                            });
                                            Navigator.pop(context);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    padding: EdgeInsets.all(5),

                                                    // shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),gapPadding: 20),
                                                    content: Row(
                                                      children: [
                                                        Text('حذف شد'),
                                                        Spacer(),
                                                        TextButton(
                                                            onPressed: () {},
                                                            child: Row(
                                                              children: const [
                                                                Icon(
                                                                    Icons.undo),
                                                                SizedBox(
                                                                    width: 3),
                                                                Text(
                                                                    'برگرداندن'),
                                                              ],
                                                            ))
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
                        ))
            ],
          ),
        ),
      ),
    );
  }

  Widget fab() {
    return FloatingActionButton(
      onPressed: () {
        AddTransaction.setDate='تنظیم کردن تاریخ';
        HomeScreen.isEditing = false;
        AddTransaction.groupId = 0;
        AddTransaction.priceController.text = '';
        AddTransaction.titleController.text = '';
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTransaction()))
            .then((value) {
          setState(() {
            MyApp.getData();

            print('فراخوانی متد ست استیت بعد از اضافه کردن تراکنش');
          });
        });
      },
      backgroundColor: kPurpleColor,
      elevation: 0,
      child: const Icon(Icons.add),
    );
  }

  Widget myAppBar(){
   return  Row(
     children: [
       Expanded(
         child: SearchBarAnimation(

           hintText: 'جست و جو کنید',
           buttonWidget: const Icon(Icons.search),
           textEditingController: searchController,
           isOriginalAnimation: false,
           secondaryButtonWidget: const Icon(Icons.close),
           enableKeyboardFocus: true,
           onSaved: (){
             print('onSaveeeee');
           },
           onExpansionComplete: (){
             print('onExpansionCompleteeeee');
           },
           // onPressButton: (v){
           //   print('open search bar');
           // },
           trailingWidget:const Icon(Icons.search),

           onCollapseComplete: (){

             searchController.text='';
             HomeScreen.money.clear();
             setState(() {
              for (var value in hiveBox.values) {
                HomeScreen.money.add(value);
              }
             });

             print('onColoapseCompleteeeee');
           },
           onFieldSubmitted: (String text){
             print('pnfieldSubmitted');

           },
           onChanged:  (String text){
             List<Money> result = hiveBox.values.where((value) => value.title.contains(text)).toList();

             HomeScreen.money.clear();
             setState(() {
               for (var value in result) {
                  HomeScreen.money.add(value);
                }
              });

           },


         ),
       ),

       const SizedBox(width: 20.0),
       const Text('تراکنش ها'),
       // Spacer(),
     ],
   );
  }

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

                  Text(HomeScreen.money[index].id.toString()),
                  SizedBox(width: 20,),


                  Text(
                    'تومان',
                    style: TextStyle(
                        color: HomeScreen.money[index].isReceived
                            ? kGreenColor
                            : kRedColor),
                  ),
                  const SizedBox(
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
  TextEditingController searchController = TextEditingController();
  Box<Money> hiveBox = Hive.box('moneyBox');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBarAnimation(

            hintText: 'جست و جو کنید',
            buttonWidget: const Icon(Icons.search),
            textEditingController: searchController,
            isOriginalAnimation: false,
            secondaryButtonWidget: const Icon(Icons.close),
            trailingWidget:const Icon(Icons.search),
            onFieldSubmitted: (String text){
              List<Money> result = hiveBox.values.where((value) => value.title.contains(text)).toList();
              print(result[0].title);

            },
            onChanged:  (String text){
              List<Money> result = hiveBox.values.where((value) => value.title.contains(text)).toList();

              HomeScreen.money.clear();

              for (var value in result) {
                HomeScreen.money.add(value);
              }
              print(result[0].title);
            },


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
