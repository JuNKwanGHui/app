import 'package:ddvision/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screen_home.dart';
import 'screen_login.dart';
import 'screen_splash.dart';
import 'screen_register.dart';
import 'screen_cut.dart';
import 'screen_gps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'model_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
      ],
      child: MaterialApp(
        title: 'D_Vision',
        theme: ThemeData(fontFamily: 'Roboto'),
        routes: {
          '/home': (context) => HomePage(),
          '/login': (context) => LoginScreen(),
          '/splash': (context) => SplashScreen(),
          '/register': (context) => RegisterScreen(),
        },
        initialRoute: '/splash',
      ),
    );

  }
}