import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        title: Text('비밀번호 변경'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                cursorColor: Colors.black, // 검정색 커서 지정
                decoration: InputDecoration(
                  labelText: '현재 비밀번호',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // 검정색으로 변경
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '올바른 비밀번호를 입력하세요';
                  }
                  // Add any additional validation logic here
                  return null;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '새 비밀번호',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                cursorColor: Colors.black, // 검정색 커서 지정
                style: TextStyle(
                  color: Colors.black, // 검정색으로 변경
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '새로운 비밀번호를 입력하세요';
                  }
                  // Add any additional validation logic here
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                cursorColor: Colors.black, // 검정색 커서 지정
                decoration: InputDecoration(
                  labelText: '새 비밀번호 확인',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // 검정색으로 변경
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '새로운 비밀번호를 입력하세요.';
                  }
                  if (value != _newPasswordController.text) {
                    return '비밀번호와 같지 않습니다.';
                  }
                  // Add any additional validation logic here
                  return null;
                },
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Process the form submission here
                      _changePassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // 검정색으로 변경
                  ),
                  child: Text('비밀번호 변경'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changePassword() {
    // Implement the password change logic here
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    // Call the appropriate method to change the password using your authentication system
    // For example, with Firebase Authentication:
    // FirebaseAuth.instance.currentUser.updatePassword(newPassword);
    // Display a success message or navigate to another page
  }
}
