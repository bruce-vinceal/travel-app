import 'package:flutter/material.dart';

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
      body: const Center(
        child: Text("This is your Profile."),
      ),
    );
  }

}
