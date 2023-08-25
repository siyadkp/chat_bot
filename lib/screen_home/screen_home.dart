import 'package:chatgpt_demo/widgets/single_chat_box_widget.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DialogFlowtter dialogFlowtter;
  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
          child: Column(
        children: [
          messages.isEmpty? const Expanded(child: Center(child: Text('Message is empty',style: TextStyle(color: Colors.white),),),)
          : Expanded(
              child: GroupedListView(
            padding: const EdgeInsets.only(right: 10, left: 10),
            reverse: true,
            order: GroupedListOrder.DESC,
            elements: messages,
            groupBy: (messages) => DateTime(2023),
            itemBuilder: (context, element) => Align(
                alignment: element['isUser']
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                child: SingleChatBox(text: element['message']!)),
            groupHeaderBuilder: (element) => const SizedBox(),
          ),),
          TextTabWithButton(
            addUserMessage: addUserMessage,
          )
        ],
      ),),
    );
  }

  addUserMessage(String message) async {
    addMessageToList(message, true);
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: message)));
    setState(() {
      addMessageToList(response.text!);
    });
  }

  addMessageToList(String message, [isUser = false]) {
    messages.add({'message': message, 'isUser': isUser});
  }
}
