import 'package:appn/Payment%20Page.dart';
import 'package:appn/all.dart';
import 'package:appn/centerIn.dart';
import 'package:appn/main.dart';
import 'package:appn/Appointments.dart';
import 'package:appn/whoPage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appn/Login.dart';
import 'package:appn/SinUp.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:appn/Verification.dart';
import 'package:appn/ProfilePersonly.dart';
import 'package:appn/Search.dart';
import 'package:appn/Chat.dart';

class profilePage1 extends StatefulWidget {
  @override
  profilePageState1 createState() => profilePageState1();
}

class profilePageState1 extends State<profilePage1> {
  CollectionReference usersref =
      FirebaseFirestore.instance.collection("Patients");
  // CollectionReference Priceref =
  //     FirebaseFirestore.instance.collection("Price");
  CollectionReference Apoimentref =
      FirebaseFirestore.instance.collection("Appointments");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: FutureBuilder(
            future: usersref
                .where("PatientID",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, i) {
                      return Column(children: [
                        Center(
                          child: Container(
                            // width: double.infinity,
                            margin: EdgeInsets.only(top: 100, bottom: 10),
                            child: ListTile(
                              title: Text(
                                "${snapshot.data.docs[i].data()['Fname']} ${snapshot.data.docs[i].data()['Lname']}",
                                style: TextStyle(
                                    color: Color(0xff807788),
                                    fontFamily: "Tajawal",
                                    fontSize: 30),
                                // textAlign: TextAlign.center
                              ),
                              subtitle: Text(
                                "${snapshot.data.docs[i].data()['Patient email']}",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 67, 43, 97),
                                    fontFamily: "El_Messiri",
                                    fontSize: 20),
                                // textAlign: TextAlign.center
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Color.fromARGB(255, 171, 169, 169),
                          height: 2,
                          thickness: 1,
                          // indent: 0,
                          // endIndent: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 40, right: 5),
                          child: ListTile(
                            leading: Icon(Icons.date_range),
                            title: Text(
                              "المواعيد",
                              style: TextStyle(
                                  fontFamily: "Tajawal",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 1, 1, 1)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => profilePage1()),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: ListTile(
                            leading: Icon(Icons.description_outlined),
                            title: Text(
                              "التقارير",
                              style: TextStyle(
                                  fontFamily: "Tajawal",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 1, 1, 1)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportsPage()),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: ListTile(
                            leading: Icon(Icons.error_outline),
                            title: Text(
                              "من نحن ؟",
                              style: TextStyle(
                                  fontFamily: "Tajawal",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 1, 1, 1)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => who()),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: ListTile(
                            leading: Icon(Icons.contact_support_outlined),
                            title: Text(
                              "تواصل معنا",
                              style: TextStyle(
                                  fontFamily: "Tajawal",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 1, 1, 1)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => contact()),
                              );
                            },
                          ),
                        ),
                      ]);
                    });
              }
              if (snapshot.hasError) {
                Text("data");
              }
              return Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 247, 11, 239)));
            },
          ),
          backgroundColor: Color(0xffEDE7F6),
        ),
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_outlined,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          // brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 130,
          title: Text("المواعيد ",
              style: TextStyle(
                  color: Color.fromARGB(255, 14, 1, 21),
                  fontFamily: "Tajawal",
                  fontSize: 35)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80)),
                color: Color(0xffffffff)
                // gradient: LinearGradient(
                //     colors: [Colors.white, Color.fromARGB(255, 168, 148, 217)],
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter)
                ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => allPages()),
                );
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            // the tab bar with two items
            // SizedBox(
            //   height: 50,
            //   child: AppBar(
            //     backgroundColor: Color(0xffEDE7F6),
            //     bottom: TabBar(
            //       labelColor: Color.fromARGB(255, 0, 0, 0),
            //       indicatorColor: Color(0xffA584B5),
            //       unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
            //       tabs: [
            //         Tab(
            //           text: "مؤخراً",
            //         ),
            //         Tab(
            //           text: "المواعيد القادمة",
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
/* ===============================================================================
===================================================================================
=================================================================================== */
            // create widgets for each tab bar here
            Expanded(
              child:
                  // TabBarView(
                  //   children: [
                  // first tab bar view widget
                  Container(
                color: Color(0xffEDE7F6),
                child: Center(
                  child: Stack(children: [
                    FutureBuilder(
                      future: Apoimentref.where("PatientID",
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    // Center(
                                    // child:
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      // color: Color.fromARGB(
                                      //     255, 255, 255, 255),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      // width: double.infinity,
                                      margin: EdgeInsets.only(
                                          top: 20, left: 10, right: 10),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              " رقم الموعد ",
                                              style: TextStyle(
                                                  color: Color(0xff807788),
                                                  fontFamily: "Tajawal",
                                                  fontSize: 20),
                                              // textAlign: TextAlign.center
                                            ),
                                            subtitle: Text(
                                                "${snapshot.data.docs[i].data()['NumAppointment']}",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 67, 43, 97),
                                                    fontFamily: "El_Messiri",
                                                    fontSize: 20),
                                                textAlign: TextAlign.center),
                                          ),
                                          ListTile(
                                            title: Text(
                                              " اليوم  ",
                                              style: TextStyle(
                                                  color: Color(0xff807788),
                                                  fontFamily: "Tajawal",
                                                  fontSize: 20),
                                              // textAlign: TextAlign.center
                                            ),
                                            subtitle: Text(
                                                "${snapshot.data.docs[i].data()['Day']}",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 67, 43, 97),
                                                    fontFamily: "El_Messiri",
                                                    fontSize: 20),
                                                textAlign: TextAlign.center),
                                          ),
                                          ListTile(
                                            title: Text(
                                              " الوقت  ",
                                              style: TextStyle(
                                                  color: Color(0xff807788),
                                                  fontFamily: "Tajawal",
                                                  fontSize: 20),
                                              // textAlign: TextAlign.center
                                            ),
                                            subtitle: Text(
                                                "${snapshot.data.docs[i].data()['Time']}",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 67, 43, 97),
                                                    fontFamily: "El_Messiri",
                                                    fontSize: 20),
                                                textAlign: TextAlign.center),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       right: 300),
                                          //   child: IconButton(
                                          //       onPressed: () {
                                          //         Navigator.push(
                                          //           context,
                                          //           MaterialPageRoute(
                                          //               builder: (context) =>
                                          //                   Addpage()),
                                          //         );
                                          //       },
                                          //       icon: Icon(Icons.add_alert)),
                                          // )
                                        ],
                                      ),
                                    ),
                                    // ),
                                    // =============================================
                                  ],
                                );
                              });
                        }
                        if (snapshot.hasError) {
                          Text("data");
                        }

                        return Center(
                            child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 247, 11, 239)));
                      },
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xffEDE7F6),
      ),
    );
  }
}

/* ============================================================================
==============================================================================
=============================================================================
============================================================================= */
class Addpage extends StatefulWidget {
  final docId;
  Addpage({Key? key, this.docId}) : super(key: key);

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  @override
  CollectionReference Invoiceref =
      FirebaseFirestore.instance.collection("Invoice");
  final _firestore = FirebaseFirestore.instance;
  var Price;
  var subscibe;
  var day;
  var time;
  bool Isnot = false;
  bool Isnot1 = false;
  bool Isnot2 = false;
  bool Isnot3 = false;
  bool Isnot4 = false;
  bool Isnot5 = false;
  bool Isnot6 = false;
  bool Isnot7 = false;
  bool Isnot8 = false;
  bool Isnot9 = false;
  // bool Isnot10 = false;
  //time1
  var color1 = Color(0xffA584B5);
  var colr2 = Color.fromARGB(255, 254, 252, 255);
  //time2
  // var color2 = Color(0xffA584B5);
  // var colr3 = Color.fromARGB(255, 254, 252, 255);
  // //tim2
  // var color3 = Color(0xffA584B5);
  // var colr4 = Color.fromARGB(255, 254, 252, 255);
  // //time3
  // var color4 = Color(0xffA584B5);
  // var colr5 = Color.fromARGB(255, 254, 252, 255);
  // //tim4
  // var color5 = Color(0xffA584B5);
  // var colr6 = Color.fromARGB(255, 254, 252, 255);
  // //time5
  // var color6 = Color(0xffA584B5);
  // var colr7 = Color.fromARGB(255, 254, 252, 255);
  // //time6
  // var color7 = Color(0xffA584B5);
  // var colr8 = Color.fromARGB(255, 254, 252, 255);
  // //tim7
  // var color8 = Color(0xffA584B5);
  // var colr9 = Color.fromARGB(255, 254, 252, 255);
  // //time8
  // var color9 = Color(0xffA584B5);
  // var colr10 = Color.fromARGB(255, 254, 252, 255);
  // //tim9
  // var color10 = Color(0xffA584B5);
  // var colr11 = Color.fromARGB(255, 254, 252, 255);
  // //tim10
  // var color11 = Color(0xffA584B5);
  // var colr12 = Color.fromARGB(255, 254, 252, 255);
  var randomNumber = random.nextInt(100000);
  var InvoiceID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
          future: usersref
              .where("PatientID",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, i) {
                    return Column(children: [
                      Center(
                        child: Container(
                          // width: double.infinity,
                          margin: EdgeInsets.only(top: 100, bottom: 10),
                          child: ListTile(
                            title: Text(
                              "${snapshot.data.docs[i].data()['Fname']} ${snapshot.data.docs[i].data()['Lname']}",
                              style: TextStyle(
                                  color: Color(0xff807788),
                                  fontFamily: "Tajawal",
                                  fontSize: 30),
                              // textAlign: TextAlign.center
                            ),
                            subtitle: Text(
                              "${snapshot.data.docs[i].data()['Patient email']}",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 67, 43, 97),
                                  fontFamily: "El_Messiri",
                                  fontSize: 20),
                              // textAlign: TextAlign.center
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Color.fromARGB(255, 171, 169, 169),
                        height: 2,
                        thickness: 1,
                        // indent: 0,
                        // endIndent: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40, right: 5),
                        child: ListTile(
                          leading: Icon(Icons.date_range),
                          title: Text(
                            "المواعيد",
                            style: TextStyle(
                                fontFamily: "Tajawal",
                                fontSize: 20,
                                color: Color.fromARGB(255, 1, 1, 1)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profilePage1()),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: ListTile(
                          leading: Icon(Icons.description_outlined),
                          title: Text(
                            "التقارير",
                            style: TextStyle(
                                fontFamily: "Tajawal",
                                fontSize: 20,
                                color: Color.fromARGB(255, 1, 1, 1)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportsPage()),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: ListTile(
                          leading: Icon(Icons.error_outline),
                          title: Text(
                            "من نحن ؟",
                            style: TextStyle(
                                fontFamily: "Tajawal",
                                fontSize: 20,
                                color: Color.fromARGB(255, 1, 1, 1)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => who()),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: ListTile(
                          leading: Icon(Icons.contact_support_outlined),
                          title: Text(
                            "تواصل معنا",
                            style: TextStyle(
                                fontFamily: "Tajawal",
                                fontSize: 20,
                                color: Color.fromARGB(255, 1, 1, 1)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => contact()),
                            );
                          },
                        ),
                      ),
                    ]);
                  });
            }
            if (snapshot.hasError) {
              Text("data");
            }
            return Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 247, 11, 239)));
          },
        ),
        backgroundColor: Color(0xffEDE7F6),
      ),
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        // brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 130,
        title: Text("المواعيد ",
            style: TextStyle(
                color: Color.fromARGB(255, 14, 1, 21),
                fontFamily: "Tajawal",
                fontSize: 35)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
              color: Color(0xffffffff)
              // gradient: LinearGradient(
              //     colors: [Colors.white, Color.fromARGB(255, 168, 148, 217)],
              //     begin: Alignment.bottomCenter,
              //     end: Alignment.topCenter)
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      /*  */
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          StreamBuilder(
              stream: Daysref.snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return Wrap(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 30, top: 20),
                              child: Text(
                                  " ${snapshot.data.docs[i].data()['day']}",
                                  style: TextStyle(
                                      color: Color(0xff8B8080),
                                      fontSize: 20,
                                      fontFamily: "El_Messiri")),
                            ),
                            //1
                            SizedBox(
                              width: 300,
                            ),
                            /* =========================================================================
                            ============================================================================ */
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time1'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time1']}",
                                    style: TextStyle(
                                        color: Isnot ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time2'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot1 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, /* right: 10, */ bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot1 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot1 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time2']}",
                                    style: TextStyle(
                                        color: Isnot1 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time3'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot2 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot2 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot2 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time3']}",
                                    style: TextStyle(
                                        color: Isnot2 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time4'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot3 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot3 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot3 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time4']}",
                                    style: TextStyle(
                                        color: Isnot3 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time5'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot4 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, /* right: 10,  */ bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot4 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot4 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time5']}",
                                    style: TextStyle(
                                        color: Isnot4 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time6'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot5 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot5 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot5 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time6']}",
                                    style: TextStyle(
                                        color: Isnot5 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time7'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot6 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot6 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot6 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time7']}",
                                    style: TextStyle(
                                        color: Isnot6 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time8'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot7 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot7 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot7 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time8']}",
                                    style: TextStyle(
                                        color: Isnot7 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time9'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot8 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot8 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot8 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time9']}",
                                    style: TextStyle(
                                        color: Isnot8 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time10'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                setState(() {
                                  Isnot9 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot9 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot9 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time10']}",
                                    style: TextStyle(
                                        color: Isnot9 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        );
                      });
                }
                return Center(
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 247, 11, 239)));
              }),
          StreamBuilder(
              stream: Daysref.snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return Wrap(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 30, top: 20),
                              child: Text(
                                  " ${snapshot.data.docs[i].data()['day']}",
                                  style: TextStyle(
                                      color: Color(0xff8B8080),
                                      fontSize: 20,
                                      fontFamily: "El_Messiri")),
                            ),
                            //1
                            SizedBox(
                              width: 300,
                            ),
                            /* =========================================================================
                            ============================================================================ */
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time1'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time1']}",
                                    style: TextStyle(
                                        color: Isnot ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time2'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot1 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, /* right: 10, */ bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot1 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot1 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time2']}",
                                    style: TextStyle(
                                        color: Isnot1 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time3'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot2 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot2 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot2 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time3']}",
                                    style: TextStyle(
                                        color: Isnot2 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time4'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot3 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot3 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot3 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time4']}",
                                    style: TextStyle(
                                        color: Isnot3 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time5'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot4 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, /* right: 10,  */ bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot4 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot4 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time5']}",
                                    style: TextStyle(
                                        color: Isnot4 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time6'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot5 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot5 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot5 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time6']}",
                                    style: TextStyle(
                                        color: Isnot5 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time7'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot6 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot6 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot6 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time7']}",
                                    style: TextStyle(
                                        color: Isnot6 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time8'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot8 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot7 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot7 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot7 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time8']}",
                                    style: TextStyle(
                                        color: Isnot7 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time9'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot9 = false;
                                setState(() {
                                  Isnot8 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot8 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot8 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time9']}",
                                    style: TextStyle(
                                        color: Isnot8 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            MaterialButton(
                              // elevation: 5,
                              onPressed: () {
                                InvoiceID = randomNumber;
                                Price = snapshot.data.docs[i].data()['Price'];
                                time = snapshot.data.docs[i].data()['time10'];
                                day = snapshot.data.docs[i].data()['day'];
                                print(time);
                                Isnot = false;
                                Isnot1 = false;
                                Isnot2 = false;
                                Isnot3 = false;
                                Isnot4 = false;
                                Isnot5 = false;
                                Isnot6 = false;
                                Isnot7 = false;
                                Isnot8 = false;
                                setState(() {
                                  Isnot9 = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 20, right: 10, bottom: 15),
                                height: 50,
                                // width: 100,
                                // width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Isnot9 ? Colors.white : color1,
                                        width: 2),
                                    color: Isnot9 ? Color(0xffA584B5) : colr2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['time10']}",
                                    style: TextStyle(
                                        color: Isnot9 ? Colors.white : color1,
                                        fontFamily: "El_Messiri",
                                        fontSize: 20),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        );
                      });
                }
                return Center(
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 247, 11, 239)));
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 179, 142, 193),
        foregroundColor: Colors.black,
        onPressed: () {
          if (Isnot == true ||
              Isnot == true ||
              Isnot1 == true ||
              Isnot2 == true ||
              Isnot3 == true ||
              Isnot4 == true ||
              Isnot5 == true ||
              Isnot6 == true ||
              Isnot7 == true ||
              Isnot8 == true ||
              Isnot9 == true) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    titlePadding: EdgeInsets.all(30),
                    backgroundColor: Color.fromARGB(235, 255, 255, 255),
                    title: Column(
                      children: [
                        ListTile(
                          title: Text(
                            " رقم الفاتورة ",
                            style: TextStyle(
                                color: Color(0xff807788),
                                fontFamily: "Tajawal",
                                fontSize: 20),
                            // textAlign: TextAlign.center
                          ),
                          subtitle: Text("$InvoiceID",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 67, 43, 97),
                                  fontFamily: "El_Messiri",
                                  fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                        ListTile(
                          title: Text(
                            "اليوم",
                            style: TextStyle(
                                color: Color(0xff807788),
                                fontFamily: "Tajawal",
                                fontSize: 20),
                            // textAlign: TextAlign.center
                          ),
                          subtitle: Text("$day",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 67, 43, 97),
                                  fontFamily: "El_Messiri",
                                  fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                        ListTile(
                          title: Text(
                            "الوقت",
                            style: TextStyle(
                                color: Color(0xff807788),
                                fontFamily: "Tajawal",
                                fontSize: 20),
                            // textAlign: TextAlign.center
                          ),
                          subtitle: Text("$time",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 67, 43, 97),
                                  fontFamily: "El_Messiri",
                                  fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                        ListTile(
                          title: Text(
                            "السعر",
                            style: TextStyle(
                                color: Color(0xff807788),
                                fontFamily: "Tajawal",
                                fontSize: 20),
                            // textAlign: TextAlign.center
                          ),
                          subtitle: Text("$Price",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 67, 43, 97),
                                  fontFamily: "El_Messiri",
                                  fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                    actions: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            if (Isnot == true ||
                                Isnot == true ||
                                Isnot1 == true ||
                                Isnot2 == true ||
                                Isnot3 == true ||
                                Isnot4 == true ||
                                Isnot5 == true ||
                                Isnot6 == true ||
                                Isnot7 == true ||
                                Isnot8 == true ||
                                Isnot9 == true) {
                              _firestore.collection('Appointments').add({
                                'NumAppointment': randomNumber,
                                'Day': day,
                                'Time': time,
                                'PatientID':
                                    FirebaseAuth.instance.currentUser!.uid,
                              });
                              _firestore.collection('Invoice').add({
                                'Invoice ID': randomNumber,
                                'Day': day,
                                'Time': time,
                                ' Price': Price,
                                'PatientID':
                                    FirebaseAuth.instance.currentUser!.uid,
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaiementPage()),
                              );
                            }
                          },
                          child: Text(
                            "أكمل",
                            style:
                                TextStyle(fontSize: 19, fontFamily: "Tajawal"),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              primary: Color.fromARGB(255, 179, 142, 193),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "إلغاء",
                            style:
                                TextStyle(fontSize: 19, fontFamily: "Tajawal"),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              primary: Color.fromARGB(255, 179, 142, 193),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      )
                    ],
                  );
                });
          } else if (Isnot != true) {
            AwesomeDialog(
                context: context,
                // title: "خطأ",
                body: Text("الرجاء اختيار الوقت المناسب  ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 146, 37, 142),
                        fontSize: 20,
                        fontFamily: "Tajawal")),
                animType: AnimType.RIGHSLIDE,
                dialogType: DialogType.WARNING,
                btnOkOnPress: () {},
                btnOkText: "حسنا",
                buttonsTextStyle:
                    TextStyle(fontSize: 20, fontFamily: "Tajawal"),
                btnOkColor: Color.fromARGB(255, 83, 16, 97),
                padding: EdgeInsets.only(bottom: 30, top: 30))
              ..show();
          }
        },
        icon: Icon(Icons.payments_outlined, color: Colors.white),
        label: Text('اكمل الدفع',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontFamily: "Tajawal")),
      ),

      //  FloatingActionButton(
      //   // mini: true,
      //   //  mouseCursor: MaterialStateMouseCursor.textable,
      //   // shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(radius) ),
      //   onPressed: () {
      //     if ( Isnot == true) {
      //       _firestore.collection('Appointments').add({
      //         'NumAppointment': randomNumber,
      //         'Day': day,
      //         'Time': time,
      //         'PatientID': FirebaseAuth.instance.currentUser!.uid,
      //       });
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => PaiementPage()),
      //       );
      //     } else if (Isnot!= true) {
      //       AwesomeDialog(
      //           context: context,
      //           // title: "خطأ",
      //           body: Text("الرجاء اختيار الوقت المناسب  ",
      //               style: TextStyle(
      //                   color: Color.fromARGB(255, 146, 37, 142),
      //                   fontSize: 20,
      //                   fontFamily: "Tajawal")),
      //           animType: AnimType.RIGHSLIDE,
      //           dialogType: DialogType.WARNING,
      //           btnOkOnPress: () {},
      //           btnOkText: "حسنا",
      //           buttonsTextStyle:
      //               TextStyle(fontSize: 20, fontFamily: "Tajawal"),
      //           btnOkColor: Color.fromARGB(255, 83, 16, 97),
      //           padding: EdgeInsets.only(bottom: 30, top: 30))
      //         ..show();
      //     }
      //   },
      //   elevation: 20,
      //   backgroundColor: Color.fromARGB(255, 68, 54, 86),
      //   child: Icon(Icons.payment_outlined),
      //   // Text(" الدفع",
      //   //     style: TextStyle(
      //   //         color: Color.fromARGB(255, 255, 255, 255),
      //   //         fontSize: 20,
      //   //         fontFamily: "Tajawal")),
      // ),
      backgroundColor: Color(0xffEDE7F6),
    );
  }
}
