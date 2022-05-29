import 'package:appn/viewCentres.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'VidoeCall.dart';
import 'login.dart';
import 'message.dart';

class chatpage extends StatefulWidget {
  String email;
  chatpage({required this.email});
  @override
  _chatpageState createState() => _chatpageState(email: email);
}

class _chatpageState extends State<chatpage> {
  String email;
  _chatpageState({required this.email});

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            padding: EdgeInsets.only(right: 30),
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VideoCallScreen()));
            },
            icon: Icon(
              Icons.videocam,
              color: Colors.black,
              size: 30,
            )),

        // brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 100,
        title: Text("إشارة",
            style: TextStyle(
                color: Color.fromARGB(255, 14, 1, 21),
                fontFamily: "Tajawal",
                fontSize: 35)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            color: Colors.white,
            // gradient: LinearGradient(
            //     colors: [Colors.white, Color.fromARGB(255, 168, 148, 217)],
            //     begin: Alignment.bottomCenter,
            //     end: Alignment.topCenter)
          ),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.only(left: 30),
              onPressed: () async {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: messages(
                email:email,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 199, 199, 199),
                        hintText: 'اكتب..',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 129, 92, 161),
                            fontFamily: "El_Messiri",
                            fontSize: 20),
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            right: 20, left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.purple),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromARGB(255, 147, 117, 152)),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {},
                      onSaved: (value) {
                        message.text = value!;
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (message.text.isNotEmpty) {
                      fs.collection('Messages').doc().set({
                        'message': message.text.trim(),
                        'time': DateTime.now(),
                        'PatientID':FirebaseAuth.instance.currentUser!.uid,
                        'email': email,
                      });

                      message.clear();
                    }
                  },
                  icon: Icon(Icons.send_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffEDE7F6),
    );
  }
}
