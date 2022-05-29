import 'package:flutter/material.dart';

void main() => runApp(const FormApp());

class FormApp extends StatefulWidget {
  const FormApp({Key? key}) : super(key: key);

  @override
  _FormAppState createState() => _FormAppState();
}

class _FormAppState extends State<FormApp> {
  String? FName;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Form Example')),
        body: Form(
          key: _key,
          child: Container(
            padding: const EdgeInsets.fromLTRB(70, 0, 10, 0),
            child: TextFormField(
              cursorColor: Color(0xff634074),
              // controller: passwordController,
              onChanged: (value) {
                FName = value;
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'الاسم الاول',
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: Color(0XFFA584B5),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xff634074),
                )),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'الرجاء عدم تركه فارغ';
                return null;
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            if (_key.currentState!.validate()) {
              _key.currentState!.save();
              print("form submitted.");
            }
          },
        ),
      ),
    );
  }
}
