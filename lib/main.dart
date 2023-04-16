import 'package:flutter/material.dart';
import 'package:stylish2023/Page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Color.fromRGBO(255, 255, 255, 1),
              )),
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
