import 'dart:io';
import 'package:appn/Appointments.dart';
import 'package:appn/whoPage.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'ProfilePersonly.dart';

CollectionReference usersref =
    FirebaseFirestore.instance.collection("Patients");
CollectionReference Vidioref = FirebaseFirestore.instance.collection("Videos");

class vids extends StatefulWidget {
  vids({Key? key}) : super(key: key);

  @override
  State<vids> createState() => _vidsState();
}

class _vidsState extends State<vids> with SingleTickerProviderStateMixin {
  bool isArea = false;
  bool isPlay = false;
  var lik;
  late VideoPlayerController _Videocontroller;
  late VideoPlayerController bisecconroller;
    void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _Videocontroller.dispose();

    super.dispose();
  }
  // final _initializeVideoPlayerFuture = _controller.initialize();

  // Widget controllerViwe(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.only(right: 75, top: 70),
  //     child: Row(
  //       children: [
  //         MaterialButton(
  //             onPressed: () async {},
  //             child: Icon(
  //               Icons.fast_rewind,
  //               size: 36,
  //               color: Colors.white,
  //             )),
  //         MaterialButton(
  //             onPressed: () async {
  //               if (isPlay) {
  //                 bisecconroller.pause();
  //               } else {
  //                 bisecconroller.play();
  //               }
  //             },
  //             child: Icon(
  //               isPlay ? Icons.pause : Icons.play_arrow,
  //               size: 36,
  //               color: Colors.white,
  //             )),
  //         MaterialButton(
  //             onPressed: () async {},
  //             child: Icon(
  //               Icons.fast_forward,
  //               size: 36,
  //               color: Colors.white,
  //             ))
  //       ],
  //     ),
  //   );
  // }

  Widget playView(BuildContext context) {
    final Videocontroller2 = _Videocontroller;
    if (Videocontroller2 != null && Videocontroller2.value.isInitialized) {
      return Container(
        margin: EdgeInsets.only(right: 30),
        height: 200,
        width: 350,
        child: VideoPlayer(Videocontroller2),
      );
    } else
      // print(Videocontroller2);
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 103, 77, 102))),
      );
      
  }

  late TabController _controller; //تعريف
  void initState() {
    super.initState();
    _controller = new TabController(
        length: 2,
        vsync: this); // داخل المثود اسوي انشلايز وعدد الاشياء الي جوا
  }

  // void onCont() async {
  //   final con = bisecconroller;
  //   if (con == null) {
  //     return;
  //   }
  //   if (!con.value.isInitialized) {
  //     return;
  //   }
  //   final playing = con.value.isPlaying;
  //   isPlay = playing;
  // }

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
        title: Text("  تعلم لغة الإشارة",
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
      ),
      body: ListView(
        children: [
          new Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: new BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: new TabBar(
              labelColor: Color.fromARGB(255, 86, 54, 137),
              labelStyle: TextStyle(fontSize: 19, fontFamily: "El_Messiri"),
              unselectedLabelColor: Color.fromARGB(255, 169, 139, 218),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color.fromARGB(255, 255, 255, 255),
              controller: _controller,
              tabs: [
                new Tab(
                  // icon: const Icon(Icons.my_location),
                  text: 'باللغة العربية',
                ),
                new Tab(
                  // icon: const Icon(Icons.my_location),
                  text: 'باللغة الانجليزية',
                ),
              ],
            ),
          ),
          new Container(
              margin: EdgeInsets.only(top: 20),
              height: 900.0, // المساحة
              child: new TabBarView(controller: _controller, children: <Widget>[
// احط الصفحات
                Stack(
                  children: [
                    isArea == false
                        ? Container(
                            // margin: EdgeInsets.only(top: 30),
                            height: 200,
                            color: Color(0xffede7f6),
                            child: ListTile(
                              title: Text("لغة الاشارة ",
                                  style: TextStyle(
                                      color: Color(0xffA584B5),
                                      fontFamily: "Tajawal",
                                      fontSize: 20)),
                              subtitle: Text(
                                "تشير احصائيات الجمعية أن عدد مترجمي الإشارة على مستوى السعودية لا يتجاوز 103 مترجم فقط ولابد من مساعدة اخواننا من الصم لتسهيل عمليه تواصلهم مع المجتمع ",
                                style: TextStyle(
                                    color: Color(0xff807788),
                                    fontFamily: "El_Messiri",
                                    fontSize: 15),
                              ),
                            ),
                          )
                        : playView(context),
                    // controllerViwe(context),
                    FutureBuilder(
                      future:
                          Vidioref.where("VideoLenguge", isEqualTo: "Ar").get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              padding: EdgeInsets.only(top: 200),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      //height: 100,
                                      width: double.infinity,
                                      //  color: Colors.red,
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        onTap: () async {
                                          setState(() {
                                            if (isArea == false) {
                                              isArea = true;
                                            }
                                          });
                                          final Videocontroller =
                                              VideoPlayerController.network(
                                                  "${snapshot.data.docs[i].data()['VideoURL']}");
                                          _Videocontroller = Videocontroller;
                                          setState(() {});
                                          Videocontroller
                                            ..initialize().then((_) {
                                              // Videocontroller.addListener(
                                              //     onCont);
                                              Videocontroller.play();
                                              setState(() {});
                                            });
                                        },
                                        title: Text(
                                            "${snapshot.data.docs[i].data()['VideoName']}",
                                            style: TextStyle(
                                                color: Color(0xffA584B5),
                                                fontFamily: "Tajawal",
                                                fontSize: 20)),
                                        subtitle: Text(
                                          "${snapshot.data.docs[i].data()['VideoLength']}",
                                          style: TextStyle(
                                              color: Color(0xff807788),
                                              fontFamily: "El_Messiri",
                                              fontSize: 15),
                                          textAlign: TextAlign.end,
                                        ),
                                        tileColor: Colors.white,
                                        minVerticalPadding: 20,
                                        leading: Image.network(
                                          "${snapshot.data.docs[i].data()['ImageURl']}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
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
                  ],
                ),

                Stack(
                  children: [
                    isArea == false
                        ? Container(
                            // margin: EdgeInsets.only(top: 30),
                            height: 200,
                            color: Color(0xffede7f6),
                            child: ListTile(
                              title: Text("لغة الاشارة ",
                                  style: TextStyle(
                                      color: Color(0xffA584B5),
                                      fontFamily: "Tajawal",
                                      fontSize: 20)),
                              subtitle: Text(
                                "تشير احصائيات الجمعية أن عدد مترجمي الإشارة على مستوى السعودية لا يتجاوز 103 مترجم فقط ولابد من مساعدة اخواننا من الصم لتسهيل عمليه تواصلهم مع المجتمع ",
                                style: TextStyle(
                                    color: Color(0xff807788),
                                    fontFamily: "El_Messiri",
                                    fontSize: 15),
                              ),
                            ),
                          )
                        : playView(context),
                    // controllerViwe(context),
                    FutureBuilder(
                      future:
                          Vidioref.where("VideoLenguge", isEqualTo: "En").get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              padding: EdgeInsets.only(top: 220),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      //height: 100,
                                      width: double.infinity,
                                      //  color: Colors.red,
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        onTap: () async {
                                          setState(() {
                                            if (isArea == false) {
                                              isArea = true;
                                            }
                                          });
                                          final Videocontroller =
                                              VideoPlayerController.network(
                                                  "${snapshot.data.docs[i].data()['VideoURL']}");
                                          _Videocontroller = Videocontroller;
                                          setState(() {});
                                          Videocontroller
                                            ..initialize().then((_) {
                                              // Videocontroller.addListener(
                                              //     onCont);
                                              Videocontroller.play();
                                              setState(() {});
                                            });
                                        },
                                        title: Text(
                                            "${snapshot.data.docs[i].data()['VideoName']}",
                                            style: TextStyle(
                                                color: Color(0xffA584B5),
                                                fontFamily: "Tajawal",
                                                fontSize: 20)),
                                        subtitle: Text(
                                          "${snapshot.data.docs[i].data()['VideoLength']}",
                                          style: TextStyle(
                                              color: Color(0xff807788),
                                              fontFamily: "El_Messiri",
                                              fontSize: 15),
                                          textAlign: TextAlign.end,
                                        ),
                                        tileColor: Colors.white,
                                        minVerticalPadding: 20,
                                        leading: Image.network(
                                          "${snapshot.data.docs[i].data()['ImageURl']}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
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

                  ],
                ),
              ])),
        ],
      ),
      backgroundColor: Color(0xffede7f6),
      //  backgroundColor: Colors.purple[200],
    );
  }
}






