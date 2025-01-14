import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter/widgets/forgot_password.dart';
import 'package:restaurant_flutter/widgets/home.dart';
import 'package:restaurant_flutter/widgets/register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Login Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                'https://image.similarpng.com/file/similarpng/very-thumbnail/2021/07/Chef-restaurant-logo-illustrations-template-on-transparent-background-PNG.png',
                width: 200,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter email',
                ),
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter password',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    var cred = await _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  } catch (e) {
                    print('an error occured $e');
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Login'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: const Text('No account? Register now')),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen()));
                  },
                  child: const Text('Forgot password'))
            ],
          ),
        ),
      ),
    );
  }
}
