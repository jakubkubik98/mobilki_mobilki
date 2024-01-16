import 'package:flutter/material.dart';
import 'shared_preferences_helper.dart';
import 'task_list_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to ToDo App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              onChanged: (value) {
                setState(() {
                  _isButtonEnabled = value.trim().length >= 3;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter your name',
                errorText: _isButtonEnabled ? null : 'Name must be at least 3 characters',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonEnabled ? _saveNameAndNavigate : null,
              child: Text('Save Name'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNameAndNavigate() {
    final String userName = _nameController.text.trim();
    SharedPreferencesHelper.saveUserName(userName);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TaskListScreen(userName: userName)),
    );
  }
}
