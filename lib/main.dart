import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:transation/screens/home_screen.dart';
import 'package:transation/screens/main_screen.dart';

import 'models/money.dart';

void main() async {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  //   runApp(MyApp());
  // });

  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox<Money>('MoneyBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  static void getData(){
    HomeScreen.money.clear();
    Box<Money> hiveBox = Hive.box<Money>('MoneyBox');
    for (var value in hiveBox.values) {
      HomeScreen.money.add(value);
    }}




  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft
  //   ]);
  //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'اپلیکیشن مدیرت مالی',
      theme: ThemeData(fontFamily: 'yekan'),
      home: MainScreen(),
    );
  }
}
