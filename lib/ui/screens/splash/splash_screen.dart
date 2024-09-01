import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/auth/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'Splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/imges/logo.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
