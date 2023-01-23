import 'package:flutter/material.dart';
import 'package:transation/constant.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

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
            const Text('تراکنش جدید'),
            Spacer(),
            const TextField(
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                hintText: "عنوان ",)
            ),
            Spacer(),
            const TextField(
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  hintText: "مبلغ",)
            ),
            Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(flex: 8),
                Radio(
                  value: 0,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                Text('دریافتی'),
                Spacer(flex: 2),
                Radio(
                  value: 1,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                Text('پرداختی'),
                Spacer(flex: 7),
                TextButton(onPressed: () {}, child: Text('تاریخ'))
              ],
            ),
            Spacer(flex: 2),
            MyButton(onPressed: (){},text: 'اضافه کردن'),

            Spacer(flex: 16,)
          ],
        ),
      ),
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
        onPressed:onPressed,
        style: TextButton.styleFrom(backgroundColor: kPurpleColor),
        child: Text(text),
      ),
    );
  }
}
