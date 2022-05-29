import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class messages extends StatefulWidget {
  String email;
  messages({required this.email});
  @override
  _messagesState createState() => _messagesState(email: email);
}

// class _messagesState extends State<messages> {
//   String email;
//   _messagesState({required this.email});
//   bool isit=false;
//   var PatientID=FirebaseAuth.instance.currentUser!.uid;
//   IsIt(){
//     if (PatientID==FirebaseAuth.instance.currentUser!.uid) {
//       isit =true;
//       print(PatientID);
//       print(email);
//     }
//   }
//     @override
//   void initState() {
//     IsIt();
//     super.initState();
//   }

//   Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
//       .collection('Messages')
//       .orderBy('time')
//       .snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: _messageStream.where((isit) => true),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("something is wrong");
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           physics: ScrollPhysics(),
//           shrinkWrap: true,
//           primary: true,
//           itemBuilder: (_, index) {
//             QueryDocumentSnapshot qs = snapshot.data!.docs[index];
//             Timestamp t = qs['time'];
//             DateTime d = t.toDate();
//             print(d.toString());
//             return Padding(
//               padding: const EdgeInsets.only(top: 8, bottom: 8),
//               child: Column(
//                 crossAxisAlignment: email == qs['PatientID']
//                     ? CrossAxisAlignment.start
//                     : CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(right: 20,top: 20),
//                     width: 300,
//                     child: ListTile(
//                       tileColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(
//                           color: Colors.white,
//                         ),
//                         borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20) ),
//                       ),
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 200,
//                             child: Text(
//                               qs['message'],
//                               softWrap: true,
//                               style: TextStyle(
//                                         color: Color(0xff807788),
//                                         fontFamily: "El_Messiri",
//                                         fontSize: 20)
//                             ),
//                           ),
//                           Text(
//                             d.hour.toString() + ":" + d.minute.toString(),
//                            style: TextStyle(
//                                         color: Color(0xff807788),
//                                         fontFamily: "El_Messiri",
//                                         fontSize: 20))
//                         ],
//                       ),

//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class coments extends StatefulWidget {
//   String CenterID;
//   coments({required this.CenterID});
//   @override
//   _comentsState createState() => _comentsState(CenterID: CenterID);
// }

class _messagesState extends State<messages> {
  // CollectionReference Centersref =
  //   FirebaseFirestore.instance.collection("Centers");
  String email;
  _messagesState({required this.email});
  void initState() {
    print(email);
    super.initState();
  }

  // ignore: prefer_final_fields
  CollectionReference<Map<String, dynamic>> _messageStream =
      FirebaseFirestore.instance.collection("Messages");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream
          .orderBy('time')
          .where("email", isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'];
            DateTime d = t.toDate();
            print(d.toString());
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: email == qs['email']
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 20),
                    width: 300,
                    child: ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Text(qs['message'],
                                softWrap: true,
                                style: TextStyle(
                                    color: Color(0xff807788),
                                    fontFamily: "El_Messiri",
                                    fontSize: 20)),
                          ),
                          Text(d.hour.toString() + ":" + d.minute.toString(),
                              style: TextStyle(
                                  color: Color(0xff807788),
                                  fontFamily: "El_Messiri",
                                  fontSize: 20))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
