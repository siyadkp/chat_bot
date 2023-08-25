import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SingleChatBox extends StatelessWidget {
  final String text;
  const SingleChatBox({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration( color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
          constraints: const BoxConstraints(maxWidth: 220),
          child:Padding(
            padding: const EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
            child: Text(text,textAlign:TextAlign.left,),
          ),),
        const SizedBox(height: 20,)
      ],
    );
  }
}