import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:transation/constant.dart';
import 'package:transation/main.dart';
import 'package:transation/models/money.dart';
import 'package:transation/screens/home_screen.dart';

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
            Text(HomeScreen.isEditing ? 'ویرایش تراکنش ' : 'تراکنش جدید'),
            const Spacer(),
            MyTexField(
                hintText: 'عنوان', controller: AddTransaction.titleController),
            const Spacer(),
            MyTexField(
                hintText: 'مبلغ', controller: AddTransaction.priceController),
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 8),
                Radio(
                  activeColor: kPurpleColor,
                  value: 1,
                  groupValue: AddTransaction.groupId,
                  onChanged: (value) {
                    setState(() => AddTransaction.groupId = value.hashCode);
                  },
                ),
                const Text('دریافتی'),
                const Spacer(flex: 2),
                Radio(
                  activeColor: kPurpleColor,
                  value: 2,
                  groupValue: AddTransaction.groupId,
                  onChanged: (value) {
                    setState(() => AddTransaction.groupId = value.hashCode);
                  },
                ),
                const Text('پرداختی'),
                const Spacer(flex: 7),
                TextButton(onPressed: ()  async {
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
                }, child:  Text(AddTransaction.setDate))
              ],
            ),
            const Spacer(flex: 2),
            MyButton(

                onPressed: () {

                  Money item = Money(
                      id:HomeScreen.isEditing?HomeScreen.idEdit: Random().nextInt(9999),
                      title: AddTransaction.titleController.text,
                      price: AddTransaction.priceController.text,
                      date:AddTransaction.setDate,
                      isReceived: AddTransaction.groupId == 1 ? true : false);


                  int index= 0;
                  MyApp.getData();
                  for(int i=0; i < hiveBox.values.length;i++)
                    {

                      if (hiveBox.values.elementAt(i).id== HomeScreen.idEdit) {
                        index = i;
                      }

                    }

                  HomeScreen.isEditing
                      ? hiveBox.putAt(index, item)
                      :hiveBox.add(item) ;

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
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(backgroundColor: kPurpleColor),
        child: Text(text),
      ),
    );
  }
}
