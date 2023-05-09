import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish2023/Page/home_page.dart';
import 'package:stylish2023/resources/api-repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: RepositoryProvider(
          create: (context) => ApiRepository(),
          child: Builder(
            builder: (context) {
              final apiRepository =
                  RepositoryProvider.of<ApiRepository>(context);
              return MyHomePage(apiRepository: apiRepository);
            },
          )),
    );
  }
}
