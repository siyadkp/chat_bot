import 'package:chatgpt_demo/screen_home/screen_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ScreenSignIn extends StatelessWidget {
  const ScreenSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.teal,
      body: Center(
        child: GestureDetector(
          onTap: () async{ if(await _handleGoogleSignIn()){
               Navigator.push(context,MaterialPageRoute(builder: (context) =>HomePage(),));
      }},
          child: Container(
            alignment: Alignment.center,
            height: 50,
          width: 200,
            decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 3),borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                SvgPicture.asset('assets/Google logo.svg'),
                Text('Sign in with google',style:TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





Future<bool> _handleGoogleSignIn() async {
  final _googleSignIn =GoogleSignIn();
  SharedPreferences isSignIn = await SharedPreferences.getInstance();
  try {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn
        .signIn();
    if (googleSignInAccount != null) {
      // Successfully signed in
      // You can access the user's details using googleSignInAccount object
      isSignIn.setBool('isSignIn', true);
      return true;
    } else {
      // User canceled the sign-in process
      return false;
    }
  } catch (error) {
    // An error occurred during sign-in
    print('Error during sign-in: $error');
    return false;
  }
}
