import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firepost/pages/detail_page.dart';
import 'package:firepost/pages/home_page.dart';
import 'package:firepost/pages/signin_page.dart';
import 'package:firepost/pages/signup_page.dart';
import 'package:firepost/services/pref_service.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // login qilingan qilinmaganiga qarab qaysi pagega borishni tanledigon method. firebase ucun
  Widget _startPage() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), // login qilingan qilinmaganini aytib beregon joyi
      builder: (BuildContext context, AsyncSnapshot userSnapshot) {
        if (userSnapshot.hasData) {
          Prefs.saveUserId(userSnapshot.data.uid);
          return HomePage();
        } else {
          Prefs.removeUserId();
          return SignInPage();
        }
      },
    );}
    // return StreamBuilder<>(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if(snapshot.hasData) {
    //         Prefs.saveUserId(snapshot.data.uid);
    //         return HomePage();
    //       } else {
    //         Prefs.removeUserId();
    //         return SignInPage();
    //       }
    // }
    // );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _startPage(),
      ),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        DetailPage.id: (context) => DetailPage(),
      },
    );
  }
}
