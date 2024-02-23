import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/form_field.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load data from SharedPreferences in initState
    _loadData();
  }

  void _loadData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedName = prefs.getString('name');
      String? savedEmail = prefs.getString('email');

      _nameController.text = savedName ?? '';
      _emailController.text = savedEmail ?? '';
    } catch (e) {
      print('Error loading data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: <Widget>[
      // Blue circle
      Positioned(
      top: -190,
        left: -130,
        child: Container(
          width: 550,
          height: 600,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepOrange,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(30.0),
        child: const Text(
          "Not Just An Ordinary Form :)",
          style: TextStyle(color: Colors.white,fontSize: 24),
        ),
      ),
      // Form
      Container(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.deepOrange,
              ),
            ),
            height: 320,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: _nameController,
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }

                        Pattern namePattern = r'^[a-zA-Z ]+$';
                        RegExp nameRegex = RegExp(namePattern.toString());

                        if (!nameRegex.hasMatch(value)) {
                          return 'Please enter a valid name';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      validator: (value) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = RegExp(pattern.toString());
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!regex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () => _submitForm(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
          const Spacer(), // Spacer to push the TextButton to the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                _getSavedData();
              },
              child: Text("Get saved data", style: TextStyle(color: Colors.deepOrange.shade700)),
            ),
          ),
      ]
    ));
  }

  void _submitForm() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name', _nameController.text);
        prefs.setString('email', _emailController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data Submitted Successfully!'),
            backgroundColor: Colors.deepOrange,
          ),
        );
        _formKey.currentState?.reset();
      }
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void _getSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('name');
    String? savedEmail = prefs.getString('email');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Name: $savedName\nEmail: $savedEmail'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
