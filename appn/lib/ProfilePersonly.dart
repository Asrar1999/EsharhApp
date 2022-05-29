// import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:appn/Appointments.dart';
import 'package:appn/Payment%20Page.dart';
import 'package:path/path.dart';
import 'package:appn/whoPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:appn/Login.dart';
import 'package:appn/main.dart';
import 'package:appn/alert.dart';
import 'package:image_picker/image_picker.dart';

class Profilepersonly extends StatefulWidget {
  const Profilepersonly({Key? key}) : super(key: key);
  State<StatefulWidget> createState() {
    return ProfilepersonlyState();
  }
}

// var user = FirebaseAuth.instance.currentUser;

class ProfilepersonlyState extends State<Profilepersonly> {
  late File image;
  final _firestore = FirebaseFirestore.instance;

  var imageURL;
  var pickedFile = ImagePicker();
  CollectionReference usersref =
      FirebaseFirestore.instance.collection("Patients");

  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

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
        title: Text("الملف الشخصي",
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
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StsrtPage()),
                );
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: Stack(children: [
        Positioned(
          height: 170,
          left: 130,
          child: Container(
            height: 141,
            width: 148,
            margin: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              radius: 100,
            ),
          ),
        ),
        Container(
          height: 1000,
          width: double.infinity,
          margin: EdgeInsets.only(top: 250),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 255, 255, 255), Colors.white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(300), topRight: Radius.circular(200)),
          ),
        ),
        //   ],
        // ),

        FutureBuilder(
          future: usersref
              .where("PatientID",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Center(
                          child: Container(
                            // width: double.infinity,
                            margin: EdgeInsets.only(top: 175),
                            child: ListTile(
                              title: Text(
                                  "${snapshot.data.docs[i].data()['Fname']} ${snapshot.data.docs[i].data()['Lname']}",
                                  style: TextStyle(
                                      color: Color(0xff807788),
                                      fontFamily: "Tajawal",
                                      fontSize: 30),
                                  textAlign: TextAlign.center),
                              subtitle: Text(
                                  "${snapshot.data.docs[i].data()['Patient email']}",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 67, 43, 97),
                                      fontFamily: "El_Messiri",
                                      fontSize: 20),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                        // =============================================
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 100),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 50),
                                child: Text("  رقم الهاتف :  ",
                                    style: TextStyle(
                                        color: Color(0xffA584B5),
                                        fontFamily: "Tajawal",
                                        fontSize: 20)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 50),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['Patient phon']}",
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
                          indent: 50,
                          endIndent: 50,
                        ),
                        // =======================================================
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 50),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 50),
                                child: Text("  تاريخ الميلاد :  ",
                                    style: TextStyle(
                                        color: Color(0xffA584B5),
                                        fontFamily: "Tajawal",
                                        fontSize: 20)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 50),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['Birthday']}",
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
                          indent: 50,
                          endIndent: 50,
                        ),
                        // ==============================================
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 50),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 50),
                                child: Text(" الجنس :  ",
                                    style: TextStyle(
                                        color: Color(0xffA584B5),
                                        fontFamily: "Tajawal",
                                        fontSize: 20)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 90),
                                child: Text(
                                    "${snapshot.data.docs[i].data()['Sex']}",
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
                          indent: 50,
                          endIndent: 50,
                        ),
                        Container(
                          color: Color(0xffA584B5),
                          margin: EdgeInsets.all(50),
                          child: ListTile(
                              leading: Icon(
                                Icons.upload_file,
                                color: Colors.white,
                                size: 30,
                              ),
                              title: Text(
                                "ارفع تقاريرك الخاصة",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontFamily: "Tajawal",
                                    fontSize: 20),
                              ),
                              onTap: () {
                                showBottmSheet(context);
                              }),
                        )
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
        ),
//_______________________________________________________________________________________________
      ]),
      backgroundColor: Color(0xffEDE7F6),
    );
  }

  showBottmSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(30),
            height: 190,
            child: Column(children: [
              Text(
                "فضلا اختار طريقة الاضافة",
                style: TextStyle(
                    color: Color(0xffA584B5),
                    fontFamily: "Tajawal",
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  var imagePicked =
                      await pickedFile.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    showLoading(context);
                    image = File(imagePicked!.path);

                    var rand = Random().nextInt(10000000);

                    var nameImage = "$rand" + basename(imagePicked.path);

                    var ref =
                        FirebaseStorage.instance.ref('PatientCases/$nameImage');

                    await ref.putFile(image);

                    imageURL = await ref.getDownloadURL();
                    _firestore.collection('PatientCases').add({
                      'ImageNum': rand,
                      'ImageURL': imageURL,
                      'PatientID': FirebaseAuth.instance.currentUser!.uid,
                    });
                  }
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportsPage()),
                  );
                },
                child: Row(children: [
                  Icon(
                    Icons.camera,
                    size: 30,
                    color: Color(0xffA584B5),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("الكاميرا",
                      style: TextStyle(
                          color: Color(0xff807788),
                          fontFamily: "El_Messiri",
                          fontSize: 20))
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  var imagePicked =
                      await pickedFile.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    showLoading(context);
                    image = File(imagePicked!.path);

                    var rand = Random().nextInt(10000000);

                    var nameImage = "$rand" + basename(imagePicked.path);

                    var ref =
                        FirebaseStorage.instance.ref('PatientCases/$nameImage');

                    await ref.putFile(image);

                    imageURL = await ref.getDownloadURL();
                    _firestore.collection('PatientCases').add({
                      'ImageNum': rand,
                      'ImageURL': imageURL,
                      'PatientID': FirebaseAuth.instance.currentUser!.uid,
                    });
                  }
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportsPage()),
                  );
                },
                child: Row(children: [
                  Icon(
                    Icons.photo,
                    color: Color(0xffA584B5),
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("الاستديو/المعرض",
                      style: TextStyle(
                          color: Color(0xff807788),
                          fontFamily: "El_Messiri",
                          fontSize: 20))
                ]),
              )
            ]),
          );
        });
  }
}

class ReportsPage extends StatefulWidget {
  ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  CollectionReference usersref =
      FirebaseFirestore.instance.collection("Patients");
  CollectionReference reportsref =
      FirebaseFirestore.instance.collection("PatientCases");
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
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 40),
                        child: ListTile(
                          leading: Icon(Icons.person,
                              size: 30, color: Color(0xff817889)),
                          title: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 100, top: 5),
                            child: MaterialButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => contact()),
                                );
                              },
                              elevation: 0,
                              color: Color(0xffEDE7F6),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text("تواصل معنا",
                                  style: TextStyle(
                                    fontFamily: "Tajawal",
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 1, 1, 1),
                                  ),
                                  textAlign: TextAlign.right),
                            ),
                          ),
                        ),
                      ),
                      // =======================================================================
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10),
                        child: ListTile(
                          leading: Icon(Icons.error_outline,
                              size: 30, color: Color(0xff817889)),
                          title: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 100, top: 5),
                            child: MaterialButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => who()),
                                );
                              },
                              elevation: 0,
                              color: Color(0xffEDE7F6),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text("من نحن ؟",
                                  style: TextStyle(
                                    fontFamily: "Tajawal",
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 1, 1, 1),
                                  ),
                                  textAlign: TextAlign.right),
                            ),
                          ),
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
        title: Text("التقارير",
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
      body: FutureBuilder(
        future: reportsref
            .where("PatientID",
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(.5),
                              spreadRadius: 5,
                              blurRadius: 4,
                              offset: Offset(0, 9))
                        ]),
                        margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          leading: Image.asset("images/report.png",
                              fit: BoxFit.cover),
                          title: Text("رقم التقرير",
                              style: TextStyle(
                                  color: Color(0xff807788),
                                  fontFamily: "Tajawal",
                                  fontSize: 30)),
                          tileColor: Colors.white,
                          subtitle: Text(
                              "${snapshot.data.docs[i].data()['ImageNum']}",
                              style: TextStyle(
                                  color: Color(0xff807788),
                                  fontFamily: "El_Messiri",
                                  fontSize: 20)),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    titlePadding: EdgeInsets.all(30),
                                    backgroundColor:
                                        Color.fromARGB(235, 255, 255, 255),
                                    title: Image.network(
                                      "${snapshot.data.docs[i].data()['ImageURL']}",
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                });
                          },
                        ),
                      )
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
      ),
      backgroundColor: Color(0xffEDE7F6),
    );
  }
}
