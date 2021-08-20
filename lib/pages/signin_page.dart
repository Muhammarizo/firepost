import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepost/pages/home_page.dart';
import 'package:firepost/pages/signup_page.dart';
import 'package:firepost/services/utils_service.dart';
import 'package:flutter/material.dart';
import 'package:firepost/services/auth_service.dart';
import 'package:firepost/services/pref_service.dart';

class SignInPage extends StatefulWidget {
  static final String id = 'signin_page';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignIn() {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;
    AuthService.signInUser(context, email, password).then((firebaseUser) => {
          _getFirebaseUser(firebaseUser),
        });
  }

  _getFirebaseUser(UserCredential firebaseUser) async {
    if (firebaseUser != null) {
     // await Prefs.saveUserId(firebaseUser.additionalUserInfo.toString());
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireToast("Check email or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _doSignIn,
              ),
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, SignUpPage.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Don't have an account",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}