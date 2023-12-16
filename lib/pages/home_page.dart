import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'), // Optional: Can be removed or customized
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              const Text('Hi, Welcome Guest',
                  style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              const Text('Checkout new books groups events places and more!'),
              SizedBox(height: 20),
    
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/b.png'),
              ), // Replace with your image path
              SizedBox(height: 20),
    
              _buildCategoryRow('Most Popular', () {/* See all action */}),
              _buildCarousel(), // Implement carousel widget for books
              _buildCategoryRow('Latest', () {/* See all action */}),
              // Implement your latest books section
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(String title, VoidCallback seeAllCallback) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title, style: const TextStyle(fontSize: 20)),
        TextButton(
          onPressed: seeAllCallback,
          child: const Text('See All'),
        ),
      ],
    );
  }

  Widget _buildCarousel() {
    // Implement carousel using a package or custom implementation
    return Container(); // Placeholder for carousel widget
  }
}
