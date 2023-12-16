import 'package:ebook/pages/sign_in.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/a.png'), // Replace with your image path
          Image.asset('assets/images/just-logo.png'), // Replace with your logo path
          const Text('Welcome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('Ebook Library System! Into a World of Stories'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignInPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Background color
              foregroundColor: Colors.white, // Font color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
