import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:arabeitak_flutter_ui/repositories/gpt.dart';
import 'package:jumping_dot/jumping_dot.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Widget> messages = [];

  @override
  Widget build(BuildContext context) {
    Color userColor = const Color(0xFFE8E8EE);
    Color GPTColor = Theme.of(context).primaryColor;
    addUserBubble(String prompt) {
      messages.add(
          // BubbleNormal(
          // BubbleSpecialOne(
          BubbleSpecialTwo(
        // BubbleSpecialThree(
        text: prompt,
        isSender: true,
        color: userColor,
        textStyle: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
      ));
      setState(() {
        messages = messages;
      });
    }

    addGPTBubble(String response) {
      messages.add(BubbleSpecialTwo(
        text: response,
        isSender: false,
        color: GPTColor,
        textStyle: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
      ));
      setState(() {
        messages = messages;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              for (var widget in messages) widget,
              const SizedBox(
                height: 100,
              )
            ]),
          ),
          MessageBar(
            sendButtonColor: GPTColor,
            onSend: ((prompt) async {
              addUserBubble(prompt.toString());
              messages.add(
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: JumpingDots(
                    // innerPadding: 20,
                    color: GPTColor,
                    radius: 10,
                    numberOfDots: 3,
                  ),
                ),
              );
              GPT().getResponse(prompt).then((response) {
                if (response != null) {
                  messages.removeLast();
                  addGPTBubble(response.toString());
                }
              });
            }),
          ),
        ],
      ),
    );
  }
}