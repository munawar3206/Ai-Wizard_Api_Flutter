import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/controller/chat_provider.dart';
import 'package:quizapp/controller/models_provider.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ModelsProvider()),
          ChangeNotifierProvider(create: (_) => ChatProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat',
          theme: ThemeData(
              scaffoldBackgroundColor: const Color.fromARGB(255, 46, 46, 46),
              appBarTheme: AppBarTheme(color: Colors.black)),
          home: ChatScreen(),
        ));
  }
}
