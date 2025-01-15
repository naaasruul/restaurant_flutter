import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter/utils/constant.dart';
import 'package:restaurant_flutter/widgets/forgot_password.dart';
import 'package:restaurant_flutter/widgets/home.dart';
import 'package:restaurant_flutter/widgets/register.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: kBoxDecoration,
        child: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: kInputDecoration.copyWith(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Enter your email'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: kInputDecoration.copyWith(
                          prefixIcon: Icon(Icons.key),
                          hintText: 'Enter your password'),
                    ),
                    // Forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()));
                            },
                            child: const Text(
                              'Forgot password',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        try {
                          var cred = await _auth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);

                          toastification.show(
                            backgroundColor: Color(0xFF74ff6b),
                            context: context,
                            // optional if you use ToastificationWrapper
                            title: Text('Welcome!'),
                            autoCloseDuration: const Duration(seconds: 2),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } catch (e) {
                          toastification.show(
                            context: context,
                            // optional if you use ToastificationWrapper
                            title:
                                Text('Sorry! Something went wrong. Try again'),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          print('an error occured $e');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const Text('Login'),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: const Text(
                          'No account? Register now',
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
