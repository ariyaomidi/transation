import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transation/screens/main_screen.dart';

void main() {


  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  //   runApp(MyApp());
  // });


  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



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
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'اپلیکیشن مدیرت مالی',
      theme: ThemeData(fontFamily: 'yekan'),
      home:MainScreen(),
    );
  }
}
