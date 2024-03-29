import 'package:flutter/material.dart';
import 'package:travel_app/CustomTextFormField.dart';
import 'package:travel_app/PasswordField.dart';
import 'package:travel_app/PrimaryButton.dart';
import 'package:travel_app/models/StorageItem.dart';
import 'package:travel_app/screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/screens/Registration.dart';
import 'package:travel_app/services/StorageService.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StorageService storageService = StorageService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                    labelText: "Email Address",
                    hintText: "Enter a valid email",
                    iconData: Icons.email,
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your email' : null,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PasswordField(
                    labelText: "Password",
                    hintText: "Enter your password",
                    obscureText: obscureText,
                    onTap: setPasswordVisibility,
                    controller: passwordController,
                    validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your password' : null,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                    text: "Login",
                    iconData: Icons.login,
                    onPressed: () => signIn(),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      const Text("New to the app?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.value.text,
            password: passwordController.value.text);

        String uid = credential.user?.uid ?? "";

        await storageService.saveData(StorageItem("uid", uid));

        Navigator.pushReplacementNamed(context, Home.routeName);
      } on FirebaseAuthException catch (e) {
        print("Firebase Authentication Error: ${e.message}");
      } catch (e) {
        print("Error: $e");
      }
    }
  }
}
