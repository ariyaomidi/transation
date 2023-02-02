import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:transation/constant.dart';
import 'package:transation/main.dart';
import 'package:transation/models/money.dart';
import 'package:transation/screens/home_screen.dart';

import '../utils/extension.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  static int groupId = 0;
  static TextEditingController titleController = TextEditingController();
  static TextEditingController priceController = TextEditingController();

  static String setDate = 'تاریخی تنظیم نشده';
  static bool isPickedDate = false;

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  Box<Money> hiveBox = Hive.box<Money>('MoneyBox');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Spacer(
                  flex: 8,
                ),
                Text(HomeScreen.isEditing ? 'ویرایش تراکنش ' : 'تراکنش جدید'),
                Spacer(
                  flex: 9,
                ),
              ],
            ),

            const Spacer(),
            MyTexField(
                hintText: 'عنوان', controller: AddTransaction.titleController),
            const Spacer(),
            MyTexField(
                hintText: 'مبلغ', controller: AddTransaction.priceController),
            Spacer(flex: ScreenSize(context).screenWidth > 330 ? 2 : 1),

            Container(
              color: Colors.red,
              width: double.infinity,
              child: Wrap(
                textDirection: TextDirection.rtl,
                // alignment: WrapAlignment.end,
                runAlignment: WrapAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                Container(

                    color: Colors.green[100],width: 150,

                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Radio(
                          activeColor: kPurpleColor,
                          value: 1,
                          groupValue: AddTransaction.groupId,
                          onChanged: (value) {
                            setState(() => AddTransaction.groupId = value.hashCode);
                          },
                        ),
                        const Text('دریافتی'),
                      ],
                    ),
                  ),

                  Container(
                    color: Colors.green[500],width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Radio(
                          activeColor: kPurpleColor,
                          value: 2,
                          groupValue: AddTransaction.groupId,
                          onChanged: (value) {
                            setState(() => AddTransaction.groupId = value.hashCode);
                          },
                        ),
                        const Text('پرداختی'),
                      ],
                    ),
                  ),

                  TextButton(
                      onPressed: () async {
                        Jalali? picked = await showPersianDatePicker(
                          context: context,
                          initialDate: Jalali.now(),
                          firstDate: Jalali(1385, 8),
                          lastDate: Jalali(1450, 9),
                        );
                        var label = picked?.formatFullDate();
                        setState(() {
                          AddTransaction.isPickedDate = true;
                          AddTransaction.setDate = label!;
                        });
                      },
                      child: Text(AddTransaction.setDate)),
                ],
              ),
            ),

            // ScreenSize(context).screenWidth>330 ?
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Spacer(flex: 8),
            //     Radio(
            //       activeColor: kPurpleColor,
            //       value: 1,
            //       groupValue: AddTransaction.groupId,
            //       onChanged: (value) {
            //         setState(() => AddTransaction.groupId = value.hashCode);
            //       },
            //     ),
            //     const Text('دریافتی'),
            //     const Spacer(flex: 2),
            //     Radio(
            //       activeColor: kPurpleColor,
            //       value: 2,
            //       groupValue: AddTransaction.groupId,
            //       onChanged: (value) {
            //         setState(() => AddTransaction.groupId = value.hashCode);
            //       },
            //     ),
            //     const Text('پرداختی'),
            //     const Spacer(flex: 7),
            //     TextButton(
            //         onPressed: () async {
            //           Jalali? picked = await showPersianDatePicker(
            //             context: context,
            //             initialDate: Jalali.now(),
            //             firstDate: Jalali(1385, 8),
            //             lastDate: Jalali(1450, 9),
            //           );
            //           var label = picked?.formatFullDate();
            //           setState(() {
            //             AddTransaction.isPickedDate = true;
            //             AddTransaction.setDate = label!;
            //           });
            //         },
            //         child: Text(AddTransaction.setDate))
            //   ],
            // ):
            // Column(
            //   children: [
            //     TextButton(
            //         onPressed: () async {
            //           Jalali? picked = await showPersianDatePicker(
            //             context: context,
            //             initialDate: Jalali.now(),
            //             firstDate: Jalali(1385, 8),
            //             lastDate: Jalali(1450, 9),
            //           );
            //           var label = picked?.formatFullDate();
            //           setState(() {
            //             AddTransaction.isPickedDate = true;
            //             AddTransaction.setDate = label!;
            //           });
            //         },
            //         child: Text(AddTransaction.setDate)),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Radio(
            //           activeColor: kPurpleColor,
            //           value: 1,
            //           groupValue: AddTransaction.groupId,
            //           onChanged: (value) {
            //             setState(() => AddTransaction.groupId = value.hashCode);
            //           },
            //         ),
            //         const Text('دریافتی'),
            //       ],
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Radio(
            //           activeColor: kPurpleColor,
            //           value: 2,
            //           groupValue: AddTransaction.groupId,
            //           onChanged: (value) {
            //             setState(() => AddTransaction.groupId = value.hashCode);
            //           },
            //         ),
            //         const Text('پرداختی'),
            //       ],
            //     ),
            //   ],
            // ),
            Spacer(flex: ScreenSize(context).screenWidth > 330 ? 2 : 1),
            MyButton(
                onPressed: () {
                  Money item = Money(
                      id: HomeScreen.isEditing
                          ? HomeScreen.idEdit
                          : Random().nextInt(9999),
                      title: AddTransaction.titleController.text,
                      price: AddTransaction.priceController.text,
                      date: AddTransaction.setDate,
                      isReceived: AddTransaction.groupId == 1 ? true : false);

                  int index = 0;
                  MyApp.getData();
                  for (int i = 0; i < hiveBox.values.length; i++) {
                    if (hiveBox.values.elementAt(i).id == HomeScreen.idEdit) {
                      index = i;
                    }
                  }

                  HomeScreen.isEditing
                      ? hiveBox.putAt(index, item)
                      : hiveBox.add(item);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                    children: [
                      TextButton(onPressed: () {}, child: const Text(' ')),
                      const Spacer(),
                      Text(HomeScreen.isEditing ? 'ویرایش کردن' : 'اضافه کردن'),
                    ],
                  )));

                  Navigator.pop(context);
                },
                text: HomeScreen.isEditing ? 'ویرایش کردن' : 'اضافه کردن'),
            const Spacer(
              flex: 16,
            )
          ],
        ),
      ),
    ));
  }
}

class MyTexField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const MyTexField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          hintText: hintText,
        ));
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenSize(context).screenWidth > 1200
          ? ScreenSize(context).screenWidth * 0.03
          : 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(backgroundColor: kPurpleColor),
        child: Text(
          text,
          style: TextStyle(
              fontSize: ScreenSize(context).screenWidth > 1200
                  ? ScreenSize(context).screenWidth * 0.01
                  : 14),
        ),
      ),
    );
  }
}
