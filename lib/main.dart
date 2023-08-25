import 'package:chatgpt_demo/screen_home/screen_home.dart';
import 'package:chatgpt_demo/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool signIn=false;
GoogleSignIn? googleSignIn;
List<Map<String,dynamic>> messages=[];


void main() {
   googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
    primaryColor: Colors.black,
     hintColor: Colors.black,
  ),
  home:signIn ? const HomePage():const ScreenSignIn()
);
  }
}

class TextTabWithButton extends StatelessWidget {
  final Function(String text) addUserMessage;
   const TextTabWithButton({super.key,required this.addUserMessage});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController=TextEditingController();
     return Padding(
       padding: const EdgeInsets.only(bottom: 28,left: 15),
       child: Row(
        children: [
        SizedBox(
          width: 310,
          height: 60,
        
          child: TextField(
            cursorColor: Colors.black,
            controller: textEditingController,
       decoration: InputDecoration(

hintText: '  Please ask your question',         enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: 1, color: Colors.greenAccent),
        borderRadius: BorderRadius.circular(50.0),
         ),
         focusedBorder:  OutlineInputBorder(
        borderSide:
            const BorderSide(width: 1, color: Colors.greenAccent),
        borderRadius: BorderRadius.circular(50.0),
         ),
       ),
     )
        ),
        const SizedBox(width: 10,),
       FloatingActionButton(onPressed: (){
        String text=textEditingController.text.trim();
        if(text.isNotEmpty){
        addUserMessage(text);
        }
       },backgroundColor: Colors.greenAccent,child:const Icon(Icons.send_outlined,color:Colors.black,),)
         ],),
     );
  }
}


Future<void> isSignInChecker()async {
  SharedPreferences isSignIn = await SharedPreferences.getInstance();

  if (isSignIn.getBool('isSignIn') == null ||
      isSignIn.getBool('isSignIn') == false) {
    signIn= false;
  } else {
    signIn= true;
  }
}