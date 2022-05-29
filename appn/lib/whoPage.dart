import 'package:appn/Appointments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appn/Login.dart';
import 'package:appn/SinUp.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:appn/Verification.dart';
import 'package:appn/ProfilePersonly.dart';
import 'package:appn/Search.dart';
import 'package:appn/Chat.dart';

class who extends StatefulWidget {
  who({Key? key}) : super(key: key);

  @override
  State<who> createState() => _whoState();
}

class _whoState extends State<who> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
        // brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 130,
        title: Text("إشارة",
            style: TextStyle(
                color: Color.fromARGB(255, 14, 1, 21),
                fontFamily: "Tajawal",
                fontSize: 35)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Container(
        height: 500,
        width: 390,
        margin: EdgeInsets.only(left: 20, right: 20, top: 50),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          // gradient: LinearGradient(
          //     colors: [Colors.white, Color.fromARGB(255, 168, 148, 217)],
          //     begin: Alignment.bottomCenter,
          //     end: Alignment.topCenter)
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              alignment: Alignment.topRight,
              //     margin: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text(" مــن نــحــن؟ ",
                  style: TextStyle(color: Color.fromARGB(255, 150, 149, 149),fontSize: 25, fontFamily: "Tajawal"),
                  textAlign: TextAlign.end),
            ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Text(
                " تطبيق إشارة هو نظام صحي متعدد الاستخدامات يستهدف فئة الصم من أصحاب الهمم، يسهل على المختصين التعامل مع هذه الفئة وتقديم الرعاية والإرشاد والتوعية على ايدي متخصصين ",
                style: TextStyle(
                    color: Color.fromARGB(255, 129, 92, 161),
                    fontFamily: "El_Messiri",
                    fontSize: 20),
              ),
            ),

            ///
            ///
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 230, 221, 244),
    );
  }
}

/* ========================================================================== */

class contact extends StatefulWidget {
  contact({Key? key}) : super(key: key);

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
        // brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 130,
        title: Text("إشارة",
            style: TextStyle(
                color: Color.fromARGB(255, 14, 1, 21),
                fontFamily: "Tajawal",
                fontSize: 35)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
              // gradient: LinearGradient(
                  color:Color.fromARGB(255, 255, 255, 255),
                  // begin: Alignment.bottomCenter,
                  // end: Alignment.topCenter)
                  ),
        ),
      ),
      body: Container(
        height: 500,
        width: 390,
        margin: EdgeInsets.only(left: 20, right: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(80)),
          // gradient: LinearGradient(
          //     colors: [Colors.white, Color.fromARGB(255, 168, 148, 217)],
          //     begin: Alignment.bottomCenter,
          //     end: Alignment.topCenter)
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, right: 60, bottom: 30),
              alignment: Alignment.topRight,
              //     margin: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text(" تـــواصـــل مـــعـــنـــا ",
                style: TextStyle(color: Color.fromARGB(255, 150, 149, 149),fontSize: 25, fontFamily: "Tajawal"),
                  textAlign: TextAlign.center),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Container(
                    // margin: EdgeInsets.only(right: 10),
                    child: Text("البريد الإلكتروني:",
                        style: TextStyle(
                            color: Color(0xffA584B5),
                            fontFamily: "Tajawal",
                            fontSize: 20)),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text("esharah2022@gmail.com",
                        style: TextStyle(
                            color: Color(0xff807788),
                            fontFamily: "El_Messiri",
                            fontSize: 20)),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color.fromARGB(255, 171, 169, 169),
              height: 2,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Container(
                    // margin: EdgeInsets.only(right: 10),
                    child: Text("  رقم الهاتف :  ",
                        style: TextStyle(
                            color: Color(0xffA584B5),
                            fontFamily: "Tajawal",
                            fontSize: 20)),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    child: Text("0564846160",
                        style: TextStyle(
                            color: Color(0xff807788),
                            fontFamily: "El_Messiri",
                            fontSize: 20)),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color.fromARGB(255, 171, 169, 169),
              height: 2,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
          ],
        ),
      ),
        backgroundColor: Color(0xffEDE7F6),
    );
  }
}
