// Importing the necessary package for Flutter

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase=FirebaseAuth.instance;

// Defining a Stateful Widget called AuthScreen
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  // Creating a State object for AuthScreen
  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

// Defining the State class for AuthScreen

class _AuthScreenState extends State<AuthScreen> {

  // Creating a GlobalKey for the Form
  final _form = GlobalKey<FormState>();

  // Variables to store the entered email and password
  var _enteredEmail = '';
  var _enteredPassword = '';

  // Variable to toggle between login and signup modes
  var _isLogin = true;

  // Function to handle form submission
  void _submit() async {

    // Check if the form is valid
    final isValid = _form.currentState!.validate();

    if(!isValid){
      return;
    }
      _form.currentState!.save();
      
    try{
      if(_isLogin){
          final UserCredential=await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword
            );
      } else {
             final UserCredential = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword 
          );        
      }
      }
        on FirebaseAuthException catch(error){
            if(error.code=='email-already-in-use'){

            }
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication Failed'),),);
  }
  }

  // Building the UI for the AuthScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Setting the background color of the screen
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Displaying the chat image
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assests/images/chat-img.png'),
              ),

              // Creating a Card widget to hold the form
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(

                      // Assigning the GlobalKey to the Form
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          // Creating a TextFormField for email
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,

                            // Validator function to check if the email is valid
                            validator: (value) {
                              if (value == null || value.trim().isEmpty || !value.contains('@')) {
                                return 'Please enter valid email address!';
                              }
                              return null;
                            },

                            // OnSave function to store the entered email
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),

                          // Creating a TextFormField for password
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,

                            // Validator function to check if the password is valid
                            validator: (value) {
                              if (value == null || value.trim().length < 8) {
                                return 'Password needs 8+ Characters';
                              }
                              return null;
                            },

                            // OnSave function to store the entered password
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),

                          // Creating an ElevatedButton for form submission
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            ),
                            child: Text(_isLogin ? 'Login' : 'SignUp'),
                          ),
                          
                          // Creating a TextButton to toggle between login and signup modes
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin ? 'Create an Account' : 'Have an Account! Login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}