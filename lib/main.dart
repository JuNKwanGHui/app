import 'package:ddvision/login_page.dart';
import 'package:ddvision/register_page.dart';
import 'package:ddvision/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'D_Vision',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      routes:{
        '/login_page': (context) => LoginPage(),
        '/register_page': (context) => RegisterPage(),
      },
      //home: LoginPage(), RegisterPage(),
      home: StartPage(),
    );
  }
}