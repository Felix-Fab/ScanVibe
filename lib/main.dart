import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:scanvibe/Pages/Scanner.dart';
import 'Firebase/firebase_controller.dart';
import 'Navigation/Navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseController.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return MaterialApp(
        title: 'ScanVibe',
        initialRoute: auth.currentUser == null ? '/' : '/navigation',
        routes: {
          '/': (context){
            return SignInScreen(
              actions: [
                AuthStateChangeAction<SignedIn>((context, state){
                  Navigator.pushReplacementNamed(context, '/navigation');
                }),
                AuthStateChangeAction<UserCreated>((context, state) {
                  Navigator.pushReplacementNamed(context, '/navigation');
                })
              ],
            );
          },
          '/navigation': (context){
            return const Navigation();
            //return Dashboard(user: auth.currentUser!);
          }
        },
    );
  }
}

