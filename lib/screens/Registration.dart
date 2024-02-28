import 'package:flutter/material.dart';
import 'package:travel_app/CustomTextFormField.dart';
import 'package:travel_app/PasswordField.dart';
import 'package:travel_app/PrimaryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/screens/Home.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
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
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                    text: "Sign Up",
                    iconData: Icons.login,
                    onPressed: () async {
                      try {
                        await signUp(
                          emailController.value.text,
                          passwordController.value.text,
                        );
                        // Optionally, show a success message or navigate to a different screen
                      } catch (e) {
                        // Handle the error and show a relevant message to the user
                        print("Sign-up failed: $e");
                        // Optionally, display an error message to the user
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sign-up failed: $e"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // PrimaryButton(
                  //   text: "Register",
                  //   iconData: Icons.login,
                  //   onPressed: (){},
                  // ),
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

  // void login() {
  //   Navigator.pushReplacementNamed(context, Home.routeName);
  // }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // If the user is created successfully, navigate to the home screen
      Navigator.pushReplacementNamed(context, Home.routeName);
    } catch (e) {
      print(e);
      // Handle the error, e.g., show an error message to the user
    }
  }
}