import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:ddvision/login_page.dart';
import 'package:ddvision/register_page.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late String _userId;
  String _message = '';
  late Authentication auth;

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('D_Vision'),),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 추가
              children: [
                loginButton(),
                registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget loginButton() {
  //   return Padding(
  //       padding: EdgeInsets.only(top: 450),
  //       child: Container(
  //         height: 50,
  //         margin: EdgeInsets.symmetric(vertical: 10), // 추가
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20)
  //             ),
  //             backgroundColor: Colors.black,
  //             foregroundColor: Colors.white,
  //             fixedSize: Size(300, 100),
  //           ),
  //           child: Text('로그인하기'),
  //           onPressed: () {
  //             Navigator.pushReplacementNamed(context, '/login_page');
  //           },
  //         ),
  //       )
  //   );
  // }
  //
  // Widget registerButton() {
  //   return Container(
  //     height: 50,
  //     margin: EdgeInsets.symmetric(vertical: 10), // 추가
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //             backgroundColor: Colors.black,
  //             foregroundColor: Colors.white,
  //             fixedSize: Size(300, 100),
  //           ),
  //           child: Text('회원가입하기'),
  //           onPressed: () {
  //             Navigator.pushReplacementNamed(context, '/register_page');
  //           },
  //         ),
  //       );
  // }




  Widget loginButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 550),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            fixedSize: Size(300, 100),
          ),
          child: Text('로그인하기'),
          onPressed: () {
            //뒤로가기 버튼 X pushReplacementNamed
            //Navigator.pushReplacementNamed(context, '/login_page');
            Navigator.pushNamed(context, '/login_page');
          },
        ),
      ),
    );
  }

  Widget registerButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            fixedSize: Size(300, 100),
          ),
          child: Text('회원가입하기'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register_page');
          },
        ),
      ),
    );
  }









}