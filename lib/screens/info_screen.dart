import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  get paymentsDay => 0;

  get receiveDay => 0;

  get titleReceiveDay => 'دریافتی امروز';

  get titlePaymentDay => 'پرداختی امروز';

  get paymentsMoth => 0;

  get receiveMonth => 0;

  get titleReceiveMonth => 'دریافتی این ماه';

  get titlePaymentMonth => 'پرداختی این ماه';

  get paymentsYear => 0;

  get receiveYear => 0;

  get titleReceiveYear => 'دریافتی امسال';

  get titlePaymentYear => 'پرداختی امسال';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('مدیریت تراکنش ها به تومان'),
              ),
              MyTransaction(
                  receive: receiveDay,
                  titleReceive: titleReceiveDay,
                  payments: paymentsDay,
                  titlePayment: titlePaymentDay),

              MyTransaction(
                  receive:receiveMonth,
                  titleReceive: titleReceiveMonth,
                  payments: paymentsMoth,
                  titlePayment: titlePaymentMonth),
              MyTransaction(
                  receive:receiveYear,
                  titleReceive: titleReceiveYear,
                  payments: paymentsYear,
                  titlePayment: titlePaymentYear),
            ],
          )
      ),
    );
  }
}
// سطر تراکنش ها به صورت یک ویجت ساخته شده
class MyTransaction extends StatelessWidget {
  const MyTransaction({
    Key? key,
    required this.receive,
    required this.titleReceive,
    required this.payments,
    required this.titlePayment,
  }) : super(key: key);

  final receive;
  final titleReceive;
  final payments;
  final titlePayment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          Text(' $receive  : $titleReceive'),
          const Spacer(),
          Text('$payments  : $titlePayment'),
          const Spacer(),
        ],
      ),
    );
  }
}
