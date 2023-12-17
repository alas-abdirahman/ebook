import 'package:ebook/helper/helper.dart';
import 'package:ebook/model/user.dart';
import 'package:ebook/pages/sign_in.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Image.asset(
                            'assets/images/just-logo.png'), // Replace with your logo path
                        const Text('SIGN UP', style: TextStyle(fontSize: 24)),
                        const Text('Enter your details'),
                        _buildTextFormField(
                            'Full Name', Icons.person, _fullNameController),
                        _buildTextFormField(
                            'Email Address', Icons.email, _emailController),
                        _buildTextFormField(
                            'Phone', Icons.phone, _phoneController),
                        _buildTextFormField(
                            'Address', Icons.home, _addressController),
                        _buildTextFormField('Username', Icons.person_outline,
                            _usernameController),
                        _buildPasswordFormField(),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Creating a new user object
                              User newUser = User(
                                fullname: _fullNameController.text,
                                phone: _phoneController.text,
                                address: _addressController.text,
                                username: _usernameController.text,
                                email: _emailController.text,
                                password: _passwordController
                                    .text, // Consider using password hashing
                              );

                              // Check if the user already exists
                              DatabaseHelper.instance
                                  .userExists(newUser.username, newUser.email)
                                  .then((exists) {
                                if (!exists) {
                                  // User does not exist, proceed with registration
                                  DatabaseHelper.instance
                                      .addUser(newUser)
                                      .then((userId) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'User registered successfully. Redirecting to Sign In...'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );

                                    // Redirect to Sign In page after a delay
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignInPage()),
                                      );
                                    });
                                  }).catchError((error) {
                                    // Handle errors, such as displaying an alert dialog
                                    print("Error registering user: $error");
                                  });
                                } else {
                                  // User already exists, show error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'User already exists. Please use a different username/email.'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Background color
                            foregroundColor: Colors.white, // Font color
                          ),
                          child: const Text('Sign Up'),
                        ),

                        // Additional UI elements (if needed)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            child: const Text('Already Have Account? Sign in'),
                            onPressed: () {
                              // Navigate to sign up page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
      String label, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        icon: Icon(icon),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        icon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
    );
  }
}
