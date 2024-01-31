import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';
import 'todo_repository.dart';

class InitialScreen extends StatefulWidget {
  final ToDoRepository todoRepository;

  InitialScreen({Key? key, required this.todoRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InitialScreenState();
  }
}

class _InitialScreenState extends State<InitialScreen> {
  String _textInput = "";
  bool _isValid = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs(); // Call _initializePrefs in initState
  }

  // Initialize _prefs asynchronously
  void _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSavedUsername();
  }

  void _loadSavedUsername() {
    String? savedUsername = _prefs.getString('username');

    if (savedUsername != null && savedUsername.length >= 3) {
      // If a valid username is already saved, navigate to the main screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return MainScreen(todoRepository: widget.todoRepository, username: savedUsername);
          },
        ),
      );
    }
  }

  void _onTextChanged(String newText) {
    setState(() {
      _textInput = newText;
      _isValid = newText.length >= 3;
    });
  }

  void _onSaveButtonClick(BuildContext context) async {
    if (_isValid) {
      // Save the username to shared preferences
      _prefs.setString('username', _textInput);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return MainScreen(todoRepository: widget.todoRepository, username: _textInput);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: _onTextChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Please input your name",
                errorText: _isValid ? null : "Name must be at least 3 characters long",
              ),
            ),
          ),
          OutlinedButton(
            onPressed: _isValid ? () => _onSaveButtonClick(context) : null,
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}
