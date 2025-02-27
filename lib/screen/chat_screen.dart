import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../main.dart';
import '../widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title, required this.apiKey});

  final String title;
  final String apiKey;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dark.jpg'),
          fit: BoxFit.cover,
          invertColors: false,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.title)
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(
                  duration: 3.seconds,
                  delay: 2000.ms,
                  color: Theme.of(context).colorScheme.primary),
          leading: IconButton(
            onPressed: () {},
            icon: const Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.menu),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Text("SAPIENZA AI",
                      style: TextStyle(
                          fontSize: 55,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold))
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                      duration: 3.seconds,
                      delay: 2000.ms,
                      color: Theme.of(context).colorScheme.primary),
            ),
            ChatWidget(apiKey: apiKey),
          ],
        ),
      ),
    );
  }
}
