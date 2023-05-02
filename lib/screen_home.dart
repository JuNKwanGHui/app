import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:ddvision/screen_community.dart';
import 'package:ddvision/screen_use.dart';
import 'package:ddvision/screen_drive.dart';
import 'package:ddvision/screen_gps.dart';
import 'package:ddvision/screen_login.dart';
import 'package:ddvision/notice_board//screen_notice.dart';
import 'package:ddvision/model_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authClient =
    Provider.of<FirebaseAuthProvider>(context, listen: false);  //로그아웃 함수선언

    // if (authClient.user?.email == null) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginScreen()),
    //   );
    // }

    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(   //상단 메뉴바
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white,
          elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            TextButton(
                onPressed: () async {
                  await authClient.logout();
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('logout!')));
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Text('로그아웃',
                  style: TextStyle(color: Colors.black87, fontSize: 15,
                      fontWeight: FontWeight.w600)
                  ,
                )
            ),
            IconButton(onPressed: (){},   //클릭 시, 계정 설정 페이지 ( 함수 구현 필요)
                icon: Icon(Icons.person))
          ]

        // leading:
        //   IconButton(
        //     icon: Icon(
        //       Icons.menu,
        //       color: Colors.black87,
        //     ),
        //     onPressed: () {
        //       Scaffold.of(context).openDrawer();
        //     },
        //     tooltip:
        //     MaterialLocalizations.of(context).openAppDrawerTooltip,
        //   ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/car1.jpeg'),
              ),
              //otherAccountsPictures: [
                // CircleAvatar(
                //   backgroundImage: AssetImage('assets/profile.png'),
                // )
              //],
              //accountEmail: Text(authClient.user!.email!),
              accountEmail: Text('qwer1234@gmail.com'),
              accountName: Text('User'),
              onDetailsPressed: () {
                print('press details');
              },
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )),
            ),
            ListTile(
              leading: Icon(
                Icons.photo_camera,
                color: Colors.grey[850],
              ),
              title: Text('블랙박스 설정'),
              onTap: () {
                print('블랙박스 설정');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => test())
                );
              },
              // trailing: Icon(Icons.add),
            ),

            ListTile(
              leading: Icon(
                Icons.gps_fixed_sharp,
                color: Colors.grey[850],
              ),
              title: Text('최근 위치'),
              onTap: () {
                print('최근 위치');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Gps())
                );
              },
              // trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.directions_bus,
                color: Colors.grey[850],
              ),
              title: Text('주행 영상'),
              onTap: () {
                print('주행 영상');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DriveVideo())
                );
              },
              // trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.question_mark,
                color: Colors.grey[850],
              ),
              title: Text('공지사항'),
              onTap: () {
                print('공지사항 클릭');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Notice())
                );
              },
              // trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('설정'),
              onTap: () {
                print('설정');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => test5())
                  );

              },
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
                padding: /*EdgeInsets.all(20.0),*/
                EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      'D_Vision',
                      style: TextStyle(color: Colors.black87, fontSize: 40),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '소트프웨어공학과 1조 졸작',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize:15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 243, 243, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black87,
                            ),
                            hintText: "검색",
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '이벤트 영상',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard('assets/images/IMG_0694.jpeg'),
                          promoCard('assets/images/two.jpg'),
                          promoCard('assets/images/three.jpg'),
                          promoCard('assets/images/four.jpg'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150, //홈 공지사항 박스
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/three.jpg')),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              stops: [
                                0.3,
                                0.9
                              ],
                              colors: [
                                Colors.black.withOpacity(.8),
                                Colors.black.withOpacity(.2)
                              ]),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '최근 위치',
                              style:
                              TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget promoCard(image) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.1,
                0.9
              ], colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.1)
              ])),
        ),
      ),
    );
  }
}

class test extends StatefulWidget {
  @override
  PageView1 createState() => PageView1();
}

class PageView1 extends State<test>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text('분실물 센터',style: TextStyle(color: Colors.black87),),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('분실물 추가');},
        tooltip: 'Increment',
        child: Icon(Icons.add),


      ),
    );
  }
}

// class test2 extends StatefulWidget {
//   @override
//   PageView2 createState() => PageView2();
// }
//
// class PageView2 extends State<test2>{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 243, 243, 1),
//       appBar: AppBar(
//         title: Text('공지사항',style: TextStyle(color: Colors.black87),),
//         iconTheme: IconThemeData(color: Colors.black87),
//         backgroundColor: Colors.white,
//         brightness: Brightness.light,
//         elevation: 0,
//       ),
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           print('공지사항 추가');},
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//
//
//       ),
//     );
//   }
// }

class test3 extends StatefulWidget {
  @override
  PageView3 createState() => PageView3();
}

class PageView3 extends State<test3>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 243, 243, 1),
        appBar: AppBar(
          title: Text('커뮤니티',style: TextStyle(color: Colors.black87),),
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white,
          elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
        )


    );
  }
}

// class test4 extends StatefulWidget {
//   @override
//   PageView4 createState() => PageView4();
// }
//
// class PageView4 extends State<test4>{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color.fromRGBO(244, 243, 243, 1),
//         appBar: AppBar(
//           title: Text('셔틀버스 좌석 예약',style: TextStyle(color: Colors.black87),),
//           iconTheme: IconThemeData(color: Colors.black87),
//           backgroundColor: Colors.white,
//           elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
//         )
//
//
//     );
//   }
// }
//
