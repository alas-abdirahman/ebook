import 'package:ebook/helper/helper.dart';
import 'package:ebook/model/user.dart';
import 'package:ebook/pages/bottom_navigation.dart';
import 'package:ebook/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                  controller: _usernameController,
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
                  controller: _passwordController,
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Assuming you have defined and initialized variables `username` and `password`
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      // Perform authentication
                      User? user = await DatabaseHelper.instance
                          .authenticateUser(username, password);

                      if (user != null) {
                        // User is authenticated
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);
                        await prefs.setString('fullname', user.fullname);
                        await prefs.setString('username', user.username);
                        await prefs.setString('email', user.email);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'User logged in successfully. Redirecting to Home...'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        // Optionally, store other user data needed for the session

                        // Navigate to the BaseWidget
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BaseWidget(key: BaseWidget.changePageKey)),
                        );
                      } else {
                        // Authentication failed - show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Authentication failed. Please try again.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
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
