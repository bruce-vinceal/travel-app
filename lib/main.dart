import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/models/routes.dart';
import 'package:travel_app/screens/Home.dart';
import 'package:travel_app/screens/Login.dart';
import 'package:travel_app/services/StorageService.dart';


// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     home: const LoginScreen(),
//     routes: routes,
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  StorageService storageService = StorageService();

  var item = await storageService.readData("uid");

  if (item != null) {
    runApp(MaterialApp(
      initialRoute: Home.routeName,
      routes: routes,
    ));
  } else {
    runApp(MaterialApp(
      initialRoute: LoginScreen.routeName,
      routes: routes,
    ));
  }
}