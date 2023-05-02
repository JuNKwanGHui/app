import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Community extends StatefulWidget {
   @override
   _Community createState() => _Community();
 }
 class _Community extends State<Community> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Color.fromRGBO(244, 243, 243, 1),
       appBar: AppBar(
         title: Text('커뮤니티'),
       ),
       body: ListView(
         padding: EdgeInsets.symmetric(vertical: 0),

       ),
     );
   }
}
class test2 extends StatefulWidget {
  @override
  PageView2 createState() => PageView2();
}

class PageView2 extends State<test2>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text('공지사항',style: TextStyle(color: Colors.black87),),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('공지사항 추가');},
        tooltip: 'Increment',
        child: Icon(Icons.add),


      ),
    );
  }
}