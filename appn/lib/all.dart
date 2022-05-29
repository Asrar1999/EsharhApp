import 'package:appn/Payment%20Page.dart';
import 'package:appn/Appointments.dart';
import 'package:appn/test2.dart';
import 'package:appn/vids.dart';
import 'package:appn/whoPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class allPages extends StatefulWidget {
  allPages({Key? key}) : super(key: key);

  @override
  State<allPages> createState() => _allPagesState();
}

class _allPagesState extends State<allPages> {
  CollectionReference usersref =
      FirebaseFirestore.instance.collection("Patients");
  var selectIndex = 0;
  List<Widget> widgetPages = [
    Profilepersonly(),
    centers(),
    // profilePage1(),
    // ReportsPage(),
    vids()
  ];
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
      bottomNavigationBar: BottomNavigationBar(
        //
        selectedLabelStyle: TextStyle(fontFamily: "Tajawal"),
        selectedItemColor: Colors.purple,
        //
        unselectedLabelStyle: TextStyle(fontFamily: "Tajawal"),
        unselectedItemColor: Colors.black,
        //
        backgroundColor: Colors.purple[50],
        elevation: 0.0,

        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        currentIndex: selectIndex,

        items: [
          BottomNavigationBarItem(
              label: " الملف الشخصي", icon: Icon(Icons.person)),
          //
          BottomNavigationBarItem(label: " الرئيسية", icon: Icon(Icons.home)),
          //
          /* BottomNavigationBarItem(
              label: "مواعيدك", icon: Icon(Icons.date_range)), */
          //
          // BottomNavigationBarItem(
          //     label: "تقاريرك", icon: Icon(Icons.description)),
          BottomNavigationBarItem(
              label: "  تعلم الاشارة", icon: Icon(Icons.video_library)),
        ],
      ),
      body: widgetPages.elementAt(selectIndex),
    );
  }
}
