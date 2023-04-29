import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class test5 extends StatefulWidget {
  @override
  PageView5 createState() => PageView5();
}

class PageView5 extends State<test5>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text('중고 장터',style: TextStyle(color: Colors.black87),),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('중고 물품 추가');},
        tooltip: 'Increment',
        child: Icon(Icons.add),


      ),
    );
  }
}
