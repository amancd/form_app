import 'package:flutter/material.dart';
import 'package:form_app/screens/second_screen.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text("Form App", style: TextStyle(color: Colors.white, fontSize: 19)),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormPage()),
          );
        }, style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.deepOrange
        ), child: const Text("Open Form")),
      ));
  }
}
