// import 'dart:html';
// import 'dart:html';
import 'dart:ui';
import 'dart:math';
import 'package:appn/Payment%20Page.dart';
import 'package:appn/coments.dart';
import 'package:appn/main.dart';
import 'package:appn/Appointments.dart';
import 'package:appn/test2.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firestore = FirebaseFirestore.instance;
TextEditingController name = new TextEditingController();
TextEditingController coment = new TextEditingController();

class viewCenters extends StatefulWidget {
  String? CenterID;
  final docId;
  final infoCentr1;
  // final coment2;
  // final viwcentER;
  viewCenters({Key? key, this.infoCentr1, this.docId, this.CenterID})
      : super(key: key);

  @override
  State<viewCenters> createState() => _viewCentersState();
}

class _viewCentersState extends State<viewCenters>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  CollectionReference Centersref =
      FirebaseFirestore.instance.collection("Centers");
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  var crname;
  final fs = FirebaseFirestore.instance;

  send() {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      if (coment.text.isNotEmpty) {
        fs.collection('comments').doc().set({
          'Comment': coment.text.trim(),
          'time': DateTime.now(),
          'Name': name.text.trim(),
          'CenterName': crname,
        });
        name.clear();
        coment.clear();
      } else {
        print("NOT valid");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
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
        toolbarHeight: 80,
        title: Text("${widget.infoCentr1['CenterName']}",
            style: TextStyle(
                color: Color.fromARGB(255, 14, 1, 21),
                fontFamily: "Tajawal",
                fontSize: 35)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(left: 30),
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
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        // margin: EdgeInsets.only(top: 30),
                        color: Colors.grey,
                        child: Image.network(
                          "${widget.infoCentr1['imegUri']}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Center(
                            child: Container(
                              height: 130,
                              width: 350,
                              margin: EdgeInsets.only(top: 150),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(20),
                                child: Text(
                                  "${widget.infoCentr1['Brief']}",
                                  style: TextStyle(
                                      fontSize: 19, fontFamily: "El_Messiri"),
                                  // textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new Container(
                            decoration: new BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: new TabBar(
                              labelColor: Color.fromARGB(255, 86, 54, 137),
                              labelStyle: TextStyle(
                                  fontSize: 19, fontFamily: "El_Messiri"),
                              unselectedLabelColor:
                                  Color.fromARGB(255, 169, 139, 218),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              controller: _controller,
                              tabs: [
                                new Tab(
                                  // icon: const Icon(Icons.home),
                                  text: 'الوصف',
                                ),
                                new Tab(
                                  // icon: const Icon(Icons.my_location),
                                  text: 'التواصل',
                                ),
                                new Tab(
                                  // icon: const Icon(Icons.my_location),
                                  text: 'التقيم',
                                ),
                              ],
                            ),
                          ),
                          new Container(
                            height: 300.0,
                            child: Stack(
                              children: [
                                new TabBarView(
                                  controller: _controller,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListView(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: new ListTile(
                                                  title: new Text(" الرؤية",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 83, 4, 135),
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  subtitle: Text(
                                                      "${widget.infoCentr1['Description1']}",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              143,
                                                              115,
                                                              158),
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "El_Messiri"),
                                                      textAlign:
                                                          TextAlign.justify),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0, bottom: 200),
                                                child: new ListTile(
                                                  title: new Text(" الرسالة",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 83, 4, 135),
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  subtitle: Text(
                                                      "${widget.infoCentr1['Description2']}",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              143,
                                                              115,
                                                              158),
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "El_Messiri"),
                                                      textAlign:
                                                          TextAlign.justify),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                                    ListView(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20, right: 20),
                                              child: new ListTile(
                                                leading: const Icon(Icons.call,
                                                    color: Color(0xff49138C),
                                                    size: 30),
                                                title: new Text(
                                                    "${widget.infoCentr1['phonNum']}",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 49, 48, 50),
                                                        fontSize: 20,
                                                        fontFamily:
                                                            "El_Messiri")),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20, right: 20),
                                              child: new ListTile(
                                                leading: const Icon(Icons.email,
                                                    color: Color(0xff49138C),
                                                    size: 30),
                                                title: new Text(
                                                    "${widget.infoCentr1['Email']}",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 143, 115, 158),
                                                        fontSize: 20,
                                                        fontFamily:
                                                            "El_Messiri")),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(
                                                  top: 20,
                                                  right: 20,
                                                  left: 190),
                                              child: new ListTile(
                                                leading: const Icon(
                                                    Icons.location_pin,
                                                    color: Color(0xff49138C),
                                                    size: 30),
                                                title: TextButton(
                                                    onPressed: (() {
                                                      launch(
                                                          '${widget.infoCentr1['location']}');
                                                    }),
                                                    child: Text(
                                                      '${widget.infoCentr1['addres']}',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              143,
                                                              115,
                                                              158),
                                                          fontSize: 19,
                                                          fontFamily:
                                                              "El_Messiri"),
                                                      textAlign:
                                                          TextAlign.start,
                                                    )),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(
                                                  top: 20,
                                                  right: 20,
                                                  left: 190),
                                              child: new ListTile(
                                                leading: const Icon(
                                                    Icons.chat_bubble_outline,
                                                    color: Color(0xff49138C),
                                                    size: 30),
                                                title: TextButton(
                                                    onPressed: (() {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    chatpage(
                                                                      email: "${widget.infoCentr1['CenterName']}",
                                                                    )),
                                                      );
                                                    }),
                                                    child: Text(
                                                      'بدء الدردشة ',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              143,
                                                              115,
                                                              158),
                                                          fontSize: 19,
                                                          fontFamily:
                                                              "El_Messiri"),
                                                      textAlign:
                                                          TextAlign.start,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                                    Stack(
                                      children: [
                                        ListView(
                                          children: [
                                            // SizedBox(height: 5),
                                            Container(
                                              height: 150,
                                              width: double.infinity,
                                              //  color: Colors.grey,
                                              padding:
                                                  EdgeInsets.only(right: 40),
                                              //  padding: EdgeInsets.only(left: 300, bottom: 200),
                                              child: Row(children: [
                                                Text("التعليقات",
                                                    style: TextStyle(
                                                        fontFamily: "Tajawal",
                                                        fontSize: 20)),
                                                SizedBox(width: 150),
                                                Icon(Icons.star,
                                                    color: Colors.yellow[700],
                                                    size: 25),
                                                Icon(Icons.star,
                                                    color: Colors.yellow[700],
                                                    size: 25),
                                                Icon(Icons.star_half,
                                                    color: Colors.yellow[700],
                                                    size: 25),
                                                Icon(Icons.star_half,
                                                    color: Colors.yellow[700],
                                                    size: 25),
                                              ]),
                                            ),

                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.70,
                                              child: coments(
                                                CenterID:
                                                    "${widget.infoCentr1['CenterName']}",
                                              ),
                                            ),
                                            Container(
                                              height: 200,
                                              width: 410,
                                              margin: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              decoration: BoxDecoration(
                                                  // color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                Radius.circular(10),
                                              )),
                                              child: Column(
                                                children: [
                                                  Form(
                                                    key: formstate,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    30,
                                                                    0,
                                                                    20,
                                                                    0),
                                                            child:
                                                                TextFormField(
                                                              controller: name,
                                                              decoration:
                                                                  InputDecoration(
                                                                icon: Icon(
                                                                  Icons.person,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                filled: true,
                                                                fillColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                hintText:
                                                                    'الاسم',
                                                                hintStyle: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            129,
                                                                            92,
                                                                            161),
                                                                    fontFamily:
                                                                        "El_Messiri",
                                                                    fontSize:
                                                                        20),
                                                                enabled: true,
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            14.0,
                                                                        bottom:
                                                                            20.0,
                                                                        top:
                                                                            20.0),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      new BorderSide(
                                                                          color:
                                                                              Colors.purple),
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .circular(10),
                                                                ),
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide: new BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          147,
                                                                          117,
                                                                          152)),
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .circular(10),
                                                                ),
                                                              ),
                                                              validator:
                                                                  (value) {},
                                                              onSaved: (value) {
                                                                name.text =
                                                                    value!;
                                                              },
                                                            )),
                                                        SizedBox(height: 30),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    30,
                                                                    0,
                                                                    20,
                                                                    0),
                                                            child:
                                                                TextFormField(
                                                              controller: coment,
                                                              decoration:
                                                                  InputDecoration(
                                                                icon: Icon(
                                                                  Icons.chat,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                filled: true,
                                                                fillColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                hintText:
                                                                    'التعليق',
                                                                hintStyle: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            129,
                                                                            92,
                                                                            161),
                                                                    fontFamily:
                                                                        "El_Messiri",
                                                                    fontSize:
                                                                        20),
                                                                enabled: true,
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            14.0,
                                                                        bottom:
                                                                            20.0,
                                                                        top:
                                                                            20.0),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      new BorderSide(
                                                                          color:
                                                                              Colors.purple),
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .circular(10),
                                                                ),
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide: new BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          147,
                                                                          117,
                                                                          152)),
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .circular(10),
                                                                ),
                                                              ),
                                                              validator:
                                                                  (value) {},
                                                              onSaved: (value) {
                                                                coment.text =
                                                                    value!;
                                                              },
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  // SizedBox(height: 0),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    crname =
                                                        '${widget.infoCentr1['CenterName']}';
                                                    send();
                                                  },
                                                  child: Text("إرسـال  ",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30,
                                                            vertical: 10),
                                                    primary: Color.fromARGB(
                                                        255, 120, 70, 138),
                                                    // shape: RoundedRectangleBorder
                                                    //     borderRadius: BorderRadius.circular(20)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 30),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 179, 142, 193),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addpage()),
          );
        },
        icon: Icon(Icons.date_range_rounded, color: Colors.white),
        label: Text('المواعيد',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontFamily: "Tajawal")),
      ),
      backgroundColor: Color(0xffEDE7F6),
    );
  }
}
