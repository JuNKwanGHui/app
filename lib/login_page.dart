import 'package:flutter/material.dart';
import 'package:ddvision/main_page.dart';
import 'authentication.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      appBar: AppBar(title: Text('로그인'),),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                emailInput(),
                passwordInput(),
                loginButton(),
                resultMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
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
        decoration: InputDecoration(hintText: 'password',
            icon: Icon(Icons.enhanced_encryption)),
      ),
    );
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
            child: Text('로그인'),
            onPressed: submit,
          ),
        )
    );
  }

  Future submit() async {
    try {
      _userId = (await auth.login(txtEmail.text, txtPassword.text))!;
    } catch(e) {
      setState(() {
        _message = e.toString();
      });
    }
    setState(() {
      _message = '${_userId} 로그인 성공';
    });
  }

  Widget resultMessage() {
    return Text(_message, style: TextStyle(fontSize: 14, color: Colors.red,
        fontWeight: FontWeight.bold));
  }
}