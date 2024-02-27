import 'package:flutter/material.dart';
import 'package:travel_app/PrimaryButton.dart';
import 'package:travel_app/screens/Login.dart';

class Settings extends StatefulWidget {
  static const String routeName = "settings";
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child:PrimaryButton(
          text: "Logout",
          iconData: Icons.logout,
          onPressed: login,
        ),
      ),
    );
  }
  void login() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
