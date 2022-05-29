import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class coments extends StatefulWidget {
  String CenterID;
  coments({required this.CenterID});
  @override
  _comentsState createState() => _comentsState(CenterID: CenterID);
}

class _comentsState extends State<coments> {
  // CollectionReference Centersref =
  //   FirebaseFirestore.instance.collection("Centers");
  String CenterID;
  _comentsState({required this.CenterID});
  void initState() {
    print(CenterID);
    super.initState();
  }

  // ignore: prefer_final_fields
  CollectionReference<Map<String, dynamic>> _comentsStream =
      FirebaseFirestore.instance.collection("comments");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _comentsStream
          .orderBy('time')
          .where("CenterName", isEqualTo: CenterID)
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
                crossAxisAlignment:
                    // CenterID == qs['CenterID']
                    CrossAxisAlignment.center,
                //     : CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 0, top: 20),
                    width: 350,
                    child: ListTile(
                      minVerticalPadding: 15,
                      leading: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
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
                      title: Container(
                        width: 200,
                        child: Text(qs['Name'],
                            softWrap: true,
                            style: TextStyle(
                                color: Color.fromARGB(255, 120, 70, 138),
                                fontFamily: "Tajawal",
                                fontSize: 20)),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Text(qs['Comment'],
                                softWrap: true,
                                style: TextStyle(
                                    color: Color(0xff807788),
                                    fontFamily: "El_Messiri",
                                    fontSize: 20),
                                    ),
                          ),
                          Text(d.hour.toString() + ":" + d.minute.toString(),
                              style: TextStyle(
                                  color: Color(0xff807788),
                                  fontFamily: "El_Messiri",
                                  fontSize: 20),
                                  )
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
