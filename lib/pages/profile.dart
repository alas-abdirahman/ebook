// ignore_for_file: use_build_context_synchronously

import 'package:ebook/helper/helper.dart';
import 'package:ebook/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = "Guest"; // Default to "Guest"
  String _fullanme = "Class Of 202"; // Default to "Guest"
  String _email = "NA";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? fullname = prefs.getString("fullname") ?? "Class Of 202";
    String? email = prefs.getString("email") ?? "NA";

    setState(() {
      _username = username ?? "Guest";
      _fullanme = fullname;
      _email = email;
    });
  }

  // State variables for form fields and switches
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  bool _enableNotifications = false;
  bool _enableDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildProfileHeader(context),
              _buildFormFields(),
              _buildSwitchListTile('Enable Notifications', _enableNotifications,
                  (value) {
                setState(() {
                  _enableNotifications = value;
                });
              }),
              _buildSwitchListTile('Enable Dark Mode', _enableDarkMode,
                  (value) {
                setState(() {
                  _enableDarkMode = value;
                });
              }),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      height: 220, // Set a specific height
      decoration: const BoxDecoration(
        color: Color(0xFF01012C), // Background color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0), // Adjust as needed
          bottomRight: Radius.circular(20.0), // Adjust as needed
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircleAvatar(
            radius: 50, // Adjust as needed
            backgroundImage: AssetImage('assets/images/ai.jpeg'),
          ),
          const SizedBox(height: 10),
          Text(_fullanme.toUpperCase().toString(),
              style: const TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildTextField('Username', _usernameController),
          _buildTextField('Email', _emailController),
          _buildTextField('Old Password', _oldPasswordController,
              isPassword: true),
          _buildTextField('New Password', _newPasswordController,
              isPassword: true),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      obscureText: isPassword,
    );
  }

  Widget _buildSwitchListTile(
      String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSaveButton() {
    Future<bool> _showConfirmationDialog(BuildContext context) async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirm'),
              content: const Text(
                  "Are you sure you want to delete your account? This action cannot be undone."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ) ??
          false; // Returning false if dialog is dismissed
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              // Confirm deletion with the user
              bool confirmDeletion = await _showConfirmationDialog(context);
              if (confirmDeletion) {
                // Assuming you have the username stored in SharedPreferences
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? username = prefs.getString('username');

                if (username != null) {
                  // Delete the user account
                  await DatabaseHelper.instance.deleteUser(username);

                  // Log out the user
                  await DatabaseHelper.logout();

                  // Navigate to the sign-in or welcome page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const SignInPage()), // Replace with your appropriate page
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Delete Account'),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () async {
              // Call the logout function
              await DatabaseHelper.logout();

              // Navigate to the sign-in or welcome page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SignInPage()), // Replace SignInPage with your login page widget
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent, // Background color
              foregroundColor: Colors.white, // Foreground color
            ),
            child: const Text('Logout'),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () async {
              // Call update user method
              bool success = await DatabaseHelper.instance.updateUser(
                _username,
                _usernameController.text.isEmpty
                    ? null
                    : _usernameController.text,
                _emailController.text.isEmpty ? null : _emailController.text,
                _oldPasswordController.text.isEmpty
                    ? null
                    : _oldPasswordController.text,
                _newPasswordController.text.isEmpty
                    ? null
                    : _newPasswordController.text,
              );

              if (success) {
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User details updated successfully'),
                    backgroundColor: Colors
                        .green, // Optional: green color for success messages
                  ),
                );
              } else {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to update user details'),
                    backgroundColor:
                        Colors.red, // Optional: red color for error messages
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Background color
              foregroundColor: Colors.white, // Foreground color
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
