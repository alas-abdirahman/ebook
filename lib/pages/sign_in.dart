import 'package:ebook/pages/bottom_navigation.dart';
import 'package:ebook/pages/sign_up.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                    'assets/images/just-logo.png'), // Replace with your logo path
                const Text('SIGN IN', style: TextStyle(fontSize: 24)),
                const Text('Enter your credentials'),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("clicked");
                      // Replace the current route with the home page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BaseWidget()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    foregroundColor: Colors.white, // Font color
                  ),
                  child: const Text('Sign In'),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: const Text('Need Account? Sign up'),
                    onPressed: () {
                      // Navigate to sign up page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: const Text('Forgot Password? Retrieve'),
                    onPressed: () {
                      // Navigate to forgot password page
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
