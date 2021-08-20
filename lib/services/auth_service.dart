import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepost/pages/signin_page.dart';
import 'package:firepost/services/pref_service.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

// SignInUser - ro'yxatdan o'tib bo'lingan accountga kirish
  static Future signInUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
      }
    }
  }

  // SignUpUser - Registration ya'ni yangi account yaratish
  static Future signUpUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email,  password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
    }
  }

  //SignOutUser -  local hotiradegi ma'lumotni ucirish orqali accounttan ciqamz
static Future<void> signOutUser(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  // Prefs.removeUserId().then((value) => {
  //   Navigator.pushReplacementNamed(context, SignInPage.id)
  // });
}
}
