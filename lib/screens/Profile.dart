import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/PrimaryButton.dart';
import 'package:travel_app/screens/Login.dart';

class Profile extends StatefulWidget {
  static const String routeName = "profile";
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child:PrimaryButton(
          text: "Logout",
          iconData: Icons.logout,
          onPressed: _signOut,
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } catch (e) {
      print("Error during sign out: $e");
    }
  }
}
