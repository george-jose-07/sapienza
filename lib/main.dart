import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sapienza1/auth/login_screen.dart';
import 'package:sapienza1/screen/splash_screen.dart';
import 'firebase_options.dart';
import 'screen/chat_screen.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    primary: Colors.blue.shade900,
    error: Colors.red.shade400,
    inversePrimary: Colors.black.withOpacity(0.7),
    secondary: Colors.purple);

// primaryColor:const  Color(0xff415a5c),
// indicatorColor:const  Color(0xffffcfa1),
// canvasColor:const  Color(0xff9dafb1)

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.blue,
    inversePrimary: Colors.white.withOpacity(0.5),
    primary: Colors.blue.shade700,
    error: Colors.red.shade400,
    secondary: Colors.purple);

void main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

String apiKey = dotenv.get('API_KEY');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sapienza AI',
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        textTheme: ThemeData().textTheme.copyWith(
              bodyLarge: TextStyle(
                  fontSize: 17, color: kDarkColorScheme.inversePrimary),
              bodyMedium: TextStyle(
                  fontSize: 15, color: kDarkColorScheme.inversePrimary),
            ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 35,
              color: kDarkColorScheme.inversePrimary,
              fontWeight: FontWeight.bold),
          elevation: 40,
          //shadowColor: Colors.lightBlue,
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        textTheme: ThemeData().textTheme.copyWith(
              bodyLarge:
                  TextStyle(fontSize: 17, color: kColorScheme.inversePrimary),
              bodyMedium:
                  TextStyle(fontSize: 15, color: kColorScheme.inversePrimary),
            ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 35,
              color: kColorScheme.inversePrimary,
              fontWeight: FontWeight.bold),
          elevation: 40,
          //shadowColor: Colors.lightBlue,
        ),
      ),
      themeMode: ThemeMode.system,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return ChatScreen(title: "SAPIENZA AI", apiKey: apiKey);
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
