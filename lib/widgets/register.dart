import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {

  // get the instance of firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final User user;

  var nameEditingController = TextEditingController();
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  var confirmPasswordEditingController = TextEditingController();
  var phoneEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Register Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               TextField(
                controller: nameEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter name',
                ),
              ),
               TextField(
                 controller: emailEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter email',
                ),
              ),
               TextField(
                 controller: passwordEditingController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                ),
              ),
               TextField(
                 controller: confirmPasswordEditingController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter password confirmation',
                ),
              ),
               TextField(
                 controller: phoneEditingController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                ),
              ),
              ElevatedButton(
                onPressed: () async{
                  try{
                   await _auth.createUserWithEmailAndPassword(email: emailEditingController.text, password: passwordEditingController.text);
                    if(user != null){
                      Navigator.pop(context);
                      var snackBar = SnackBar(content: Text('register successful'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }catch(e){
                    print('An error occured $e');
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Register'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? login now')),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
