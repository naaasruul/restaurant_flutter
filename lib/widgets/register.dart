import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter/utils/constant.dart';

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
      body: Container(
        padding: const EdgeInsets.all(8.0),

        height: MediaQuery.of(context).size.height,
        decoration: kBoxDecoration,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 16,),

                   TextField(
                    controller: nameEditingController,
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your name',
                      prefixIcon: Icon(Icons.person)
                    ),
                  ),
                  SizedBox(height: 16,),

                   TextField(
                     controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email)
                    ),
                  ),
                  SizedBox(height: 16,),

                   TextField(
                     controller: passwordEditingController,
                    obscureText: true,
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter password',
                      prefixIcon: Icon(Icons.key),
                    ),
                  ),
                  SizedBox(height: 16,),

                   TextField(
                     controller: confirmPasswordEditingController,
                    obscureText: true,
                    decoration:kInputDecoration
                     .copyWith(
                      hintText: 'Enter password confirmation',
                      prefixIcon: Icon(Icons.lock)
                    ),
                  ),
                   SizedBox(height: 16,),
                   TextField(
                     controller: phoneEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter phone number',
                      prefixIcon: Icon(Icons.phone)
                    ),
                  ),
                  SizedBox(height: 32,),

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
                      child: const Text('Already have an account? login now',style: TextStyle(color: Colors.white),)),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
