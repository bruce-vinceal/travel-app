import 'package:flutter/material.dart';
import 'package:travel_app/CustomTextFormField.dart';
import 'package:travel_app/PasswordField.dart';
import 'package:travel_app/PrimaryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/screens/Home.dart';
import 'package:travel_app/screens/Login.dart';

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
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Email Address",
                    hintText: "Enter a valid email",
                    iconData: Icons.email,
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                    // Validation added for email
                    validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your email' : null,
                  ),
                  const SizedBox(height: 20.0),
                  PasswordField(
                    labelText: "Password",
                    hintText: "Enter your password",
                    obscureText: obscureText,
                    onTap: setPasswordVisibility,
                    controller: passwordController,
                    // Validation added for password
                    validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your password' : null,
                  ),
                  const SizedBox(height: 20.0),
                  PrimaryButton(
                    text: "Sign Up",
                    iconData: Icons.login,
                    onPressed: () => signUp(),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Text("Already have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: const Text(
                          "Sign In",
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

  Future<void> signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text,
        );

        Navigator.pushReplacementNamed(context, Home.routeName);
      } catch (e) {
        print("Sign-up failed: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign-up failed: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
