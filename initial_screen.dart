import 'package:flutter/material.dart';
import 'main_screen.dart';

class InitialScreen extends StatefulWidget {
  InitialScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InitialScreenState();
  }
}

class _InitialScreenState extends State<InitialScreen> {
  // Variable stores user input from text field
  String _textInput = "";
  // Variable used to store error information, it it's not null then an
  // error is set, otherwise validation is correct
  String? _error = null;

  // Method called every time when text is changed
  void _onTextChanged(String newText) {
    setState(() {
      // Set our variable to store new text
      _textInput = newText;
      // If text length is less than 3 characters, set the error message
      // otherwise, set null to remove the error
      if (_textInput.length < 3) {
        _error = "Name must be at least 3 characters long";
      } else {
        _error = null;
      }
    });
  }

  // Method called when save button is clicked
  // BuildContext is required to use navigator
  void _onSaveButtonClick(BuildContext context) {
    // Use the navigator to push new screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          // Create an instance of new screen and
          // pass user input to main screen
          return MainScreen(username: _textInput);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Initial Screen"),
      ),
      body: Column(
        children: [
          // Padding used to add margin on all sides of textfield
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              // Use our method here to update text input
              onChanged: _onTextChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Please input your name",
                errorText: _error,
              ),
            ),
          ),
          OutlinedButton(
            // When error is not null, we pass null as onPressed to make the
            // button disabled. Otherwise, call our method
            onPressed: (_error != null)
                ? null
                : () {
                    _onSaveButtonClick(context);
                  },
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}
