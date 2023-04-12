import 'package:flutter/material.dart';
import 'package:ddvision/login_page.dart';
import 'authentication.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      appBar: AppBar(title: Text('회원가입'),),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                emailInput(),
                passwordInput(),
                registerButton(),
                // cancelButton(),
                //resultMessage(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: TextFormField(
        controller: txtEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: 'email', icon: Icon(Icons.mail)),
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: TextFormField(
        obscureText: true,
        controller: txtPassword,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'password',
            icon: Icon(Icons.enhanced_encryption)
        ),
      ),
    );
  }

  Widget registerButton() {
    return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              fixedSize: Size(300, 100),
            ),
            child: Text('회원가입'),
            onPressed: submit,
          ),
        )
    );
  }

  Future submit() async {
    try {
      _userId = (await auth.signUp(txtEmail.text, txtPassword.text))!;
      setState(() {
        _message = '${_userId} 회원가입 성공';
      });
    } catch(e) {
      setState(() {
        _message = e.toString();
      });
    }
  }

  Widget loginButton() {
    return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Container(height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              fixedSize: Size(300, 100),
            ),
            child: Text('로그인하러 가기'),
            onPressed: () {
              //Navigator.pushReplacementNamed(context, '/login_page');
              Navigator.pushNamed(context, '/login_page');
            },
          ),
        )
    );
  }
}