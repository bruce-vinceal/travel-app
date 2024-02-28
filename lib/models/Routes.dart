import 'package:flutter/material.dart';
import 'package:travel_app/screens/AddItinerary.dart';
import 'package:travel_app/screens/Itinerary.dart';
import 'package:travel_app/screens/Login.dart';
import 'package:travel_app/screens/Dashboard.dart';
import 'package:travel_app/screens/Details.dart';
import 'package:travel_app/screens/Home.dart';
import 'package:travel_app/screens/Profile.dart';
import 'package:travel_app/screens/Registration.dart';
import 'package:travel_app/screens/Search.dart';
import 'package:travel_app/screens/Settings.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
  Dashboard.routeName: (BuildContext context) => const Dashboard(),
  Details.routeName: (BuildContext context) => const Details(),
  Settings.routeName: (BuildContext context) => const Settings(),
  Search.routeName: (BuildContext context) => const Search(),
  Profile.routeName: (BuildContext context) => const Profile(),
  Home.routeName: (BuildContext context) => const Home(),
  RegisterScreen.routeName: (BuildContext context) => const RegisterScreen(),
  AddItinerary.routeName: (BuildContext context) => const AddItinerary(),
  Itinerary.routeName: (BuildContext context) => const Itinerary(),
};
