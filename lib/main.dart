import 'package:flutter/material.dart';
import 'package:transation/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'اپلیکیشن مدیرت مالی',
      theme: ThemeData(fontFamily: 'yekan'),
      home:MainScreen(),
    );
  }
}
