import 'package:app_listagem/src/views/add_page.dart';
import 'package:app_listagem/src/views/main_page.dart';
import 'package:app_listagem/src/views/update_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => const MainPage(),
        "/add_page": (context) => const AddPage(),
        "/update_page": (context) => const UpdatePage()
      },
    );
  }
}
