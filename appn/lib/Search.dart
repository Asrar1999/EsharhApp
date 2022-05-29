import 'dart:io';
import 'package:appn/Payment%20Page.dart';
import 'package:appn/centerIn.dart';
import 'package:appn/Appointments.dart';
import 'package:appn/viewCentres.dart';
import 'package:appn/whoPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:appn/Login.dart';
import 'package:appn/main.dart';
import 'package:appn/alert.dart';

import 'ProfilePersonly.dart';

CollectionReference usersref =
    FirebaseFirestore.instance.collection("Patients");

// class DataSearch extends SearchDelegate<String> {
//   final centrss = [
//     "MAKKAH",
//     "JEDDAH",
//     "RIYADH",
//     "TAIF",
//     "MADDINAH",
//     "ABHA",
//     "ALBAHA",
//     "SCACA",
//     "TABUK",
//     "GAZAN"
//   ];

//   // final recentCities = [
//   //   //السيرشات اللي قد سواها المستخدم قبل تظهر له بالشاشه وقت البحث زي سجل بيانات البحث
//   //   "MAKKAH",
//   //   "JEDDAH",
//   //   "RIYADH",
//   //   "TAIF",
//   // ];
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // action for app barsearch
//     // لمن يكون عندي السيرش ايش راح تكون ردة الفعل
//     return [
//       IconButton(
//           onPressed: () {
//             query = " ";
//           },
//           icon: Icon(Icons.clear))
//     ];
//     //  throw UnimplementedError();
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     // leading icon on the left of app bar search
//     return IconButton(
//       onPressed: () {
//         close(context, "$Null");
//       },
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//     );
//     // throw UnimplementedError();
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // show thr result based on the selection
//     // يظهر نتيجة البحث اللي بحثته في اللي تحت
//     return Text("$query");
//     // Container(
//     //   height: 100,
//     //   width: 100,
//     //   child: Card(
//     //     color: Colors.red,
//     //     child: Center(
//     //       child: Text(query),
//     //     ),
//     //   ),
//     // );
//     // throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // show when someone seazrches for anything
//     // ايش تبغى يظهر لمن احد يسوي سيرش
//     List suggestionList =
//         centrss.where((element) => element.startsWith(query)).toList();
//     // final suggestionList = query.isEmpty
//     //     ? recentCities
//     //     : cities.where((p) => p.startsWith(query)).toList();

//     return ListView.builder(
//         itemCount: query == " " ? centrss.length : suggestionList.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               query = query == " " ? centrss[index] : suggestionList[index];
//               showResults(context);
//             },
//             child: Container(
//                 padding: EdgeInsets.all(10),
//                 child: query == " "
//                     ? Text(
//                         "${centrss[index]}",
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )
//                     : Text(
//                         "${suggestionList[index]}",
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       )),
//           );
//         });
//   }
// }
List<String> centert = [];
CollectionReference Centersref =
    FirebaseFirestore.instance.collection("Centers");
TextEditingController editingController = TextEditingController();

class centers extends StatefulWidget {
  centers({Key? key}) : super(key: key);

  @override
  State<centers> createState() => _centersState();
}

class _centersState extends State<centers> {
  late String name;
  List<String> centrr = [];
  var items = <String>[];
  getData() async {
    var responsbody = await Centersref.get();
    responsbody.docs.forEach((element) {
      setState(() {
        centrr.add('${element.data()}');
      });
    });
    print(centrr);
  }

  void initState() {
    items.addAll(centrr);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(centrr);
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(centrr);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              getData();
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        // brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 130,
        title: Container(
          child: Text("إشارة",
             style: TextStyle(
                color: Color.fromARGB(255, 14, 1, 21),
                fontFamily: "Tajawal",
                fontSize: 35)
          ),
          // child: Column(
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: TextField(
          //         onChanged: (value) {
          //           filterSearchResults(value);
          //         },
          //         controller: editingController,
          //         decoration: InputDecoration(
          //             labelText: "Search",
          //             hintText: "Search",
          //             prefixIcon: Icon(Icons.search),
          //             border: OutlineInputBorder(
          //                 borderRadius:
          //                     BorderRadius.all(Radius.circular(25.0)))),
          //       ),
          //     ),
          //   ],
          // ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
              gradient: LinearGradient(
                  colors: [Color(0xffEDE7F6), Colors.white],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        // actions: <Widget>[
        //     Padding(
        //     padding: const EdgeInsets.only(top :100.0),
        //     child: TextField(
        //       onChanged: (value) {
        //         filterSearchResults(value);
        //       },
        //       controller: editingController,
        //       decoration: InputDecoration(
        //           labelText: "Search",
        //           hintText: "Search",
        //           prefixIcon: Icon(Icons.search),
        //           border: OutlineInputBorder(
        //               borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        //     ),
        //   ),
        // ]
      ),
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
      body: Stack(children: [
        FutureBuilder(
          future: Centersref.get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  // padding: EdgeInsets.only(top: 150),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, i) {
                    return continersersh(
                        infoCentr: snapshot.data.docs[i],
                        docId: snapshot.data.docs[i].id);
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
        /*  ],
          ), */
      ]),
      backgroundColor: Colors.white,
    );
  }
}

class continersersh extends StatelessWidget {
  final docId;
  final infoCentr;
  const continersersh({Key? key, this.infoCentr, this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        var name2 = "${infoCentr['CenterName']}";
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return viewCenters(infoCentr1: infoCentr);
          }),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffEDE7F6), borderRadius: BorderRadius.circular(20)),
        height: 300,
        margin: EdgeInsets.only(top: 50),
        width: double.infinity,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // margin: EdgeInsets.all(),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text("${infoCentr['CenterName']}",
                        style: TextStyle(
                            color: Color(0xff807788),
                            fontFamily: "Tajawal",
                            fontSize: 30),
                        textAlign: TextAlign.start),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    // padding:
                    //     EdgeInsets.only( bottom: 50),
                    child: Text(
                      "${infoCentr['Brief']}",
                      style: TextStyle(
                          color: Color(0xff807788),
                          fontFamily: "El_Messiri",
                          fontSize: 20),
                      // textAlign: TextAlign.center
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 200,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.5),
                          child: Icon(Icons.pin_drop_outlined,
                              color: Color.fromARGB(255, 75, 48, 111)),
                        ),
                        Text(
                          "${infoCentr['addres']}",
                          style: TextStyle(
                              color: Color(0xff807788),
                              fontFamily: "El_Messiri",
                              fontSize: 20),
                          // textAlign: TextAlign.end
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
