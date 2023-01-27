import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transation/constant.dart';
import 'package:transation/models/money.dart';
import 'package:transation/screens/home_screen.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  static int groupId = 0;
  static TextEditingController titleController = TextEditingController();
  static TextEditingController priceController = TextEditingController();

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
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
                TextButton(onPressed: () {}, child: const Text('تاریخ'))
              ],
            ),
            const Spacer(flex: 2),
            MyButton(
                onPressed: () {
                  Money item = Money(
                      id: Random().nextInt(9999),
                      title: AddTransaction.titleController.text,
                      price: AddTransaction.priceController.text,
                      date: '1402/06/08',
                      isReceived: AddTransaction.groupId == 1 ? true : false);

                  HomeScreen.isEditing
                      ? HomeScreen.money[HomeScreen.indexEditing] = item
                      :HomeScreen.money.add(item) ;

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
