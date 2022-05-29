import 'package:appn/Payment%20Page.dart';
import 'package:appn/all.dart';
import 'package:appn/centerIn.dart';
import 'package:appn/Appointments.dart';
import 'package:appn/test.dart';
import 'package:appn/test2.dart';
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
import 'package:appn/vids.dart';

// import 'package:select_form_field/select_form_field.dart';

bool? isloin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isloin = false;
  } else {
    isloin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isloin == false ? HomePage()
            :
          // Addpage()
            // vids()
            // chatpage(email: '',)
            // ReportsPage()
            //  VideoPlayerApp()
            // centersIn()
            // DoctorDetailPage()
            // MyHomePage(title: '',)
            allPages()
        // PaiementPage1()    
        // profilePage1()
        // cee()
        // centers ()
        // seearch1()
        // ChatPage()
        //  Profilepersonly1(),

        );
  }
}

class HomePage extends StatelessWidget {
  // الصفحة الرئيسية
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              // margin: EdgeInsets.only(left: 200,top: 45),
              child: Image.asset(
            "images/1.png",
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          )),
          Container(
            margin: EdgeInsets.only(top: 450, right: 110),
            child: Text(
              "إشــــارة",
              style: TextStyle(
                  fontFamily: "Tajawal",
                  fontSize: 50,
                  color: Colors.deepPurple[500],
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 550, right: 50),
            child: Text(
              "أهلًا بكم في تطبيق إشارة",
              style: const TextStyle(
                fontSize: 30,
                fontFamily: "El_Messiri",
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 700, right: 30),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StsrtPage()),
                  );
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Color(0xff000000),
                iconSize: 30,
              ))
        ],
      ),
    );
  } // end Wedget build
} // end class homepage

class StsrtPage extends StatefulWidget {
  const StsrtPage({Key? key}) : super(key: key);
  State<StatefulWidget> createState() {
    return StsrtPageState();
  }
}

class StsrtPageState extends State<StsrtPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: Stack(
              // alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 500,
                  left: 10,
                  child: Image.asset(
                    "images/Group 10.png",
                    // width: 400,
                    // height: 900,
                  ),
                ),
                //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                //1
                TabBarView(children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 250, right: 90, left: 90),
                          child: Image.asset(
                            "images/Navigation-amico.png",
                            // width: 400,
                            // height: 400,
                          ),
                        ),
                        ListTile(
                          title: Text(" المراكز",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 36, 65),
                                  fontFamily: "Tajawal",
                                  fontSize: 30),
                              textAlign: TextAlign.center),
                          minVerticalPadding: 30,
                          subtitle: Text(
                              " عرض جميع المراكز القريبة من المريض وتحديد موقعها.",
                              style: TextStyle(
                                  color: Color(0xff807788),
                                  fontFamily: "Tajawal",
                                  fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  // Text("معرفة مواقع المراكز"),
                  //2
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 200, right: 10),
                          // padding: const EdgeInsets.only(top: 190, left: 150),
                          child: Image.asset(
                            "images/Video call-amico.png",

                            // width: 400,
                            // height: 400,
                          ),
                        ),
                        ListTile(
                          title: Text(" التواصل مع المراكز",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 36, 65),
                                  fontFamily: "Tajawal",
                                  fontSize: 30),
                              textAlign: TextAlign.center),
                          minVerticalPadding: 70,
                          subtitle: Text(
                              "يمكن للمرضى التواصل مع المركز عن طريق المحادثات المكتوبة والمرئية.",
                              style: TextStyle(
                                  color: Color(0xff807788),
                                  fontFamily: "Tajawal",
                                  fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  //3
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 190),
                          child: Image.asset(
                            "images/Schedule-rafiki.png",

                            // width: 400,
                            // height: 400,
                          ),
                        ),
                        ListTile(
                          title: Text(" المواعيد ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 36, 65),
                                  fontFamily: "Tajawal",
                                  fontSize: 30),
                              textAlign: TextAlign.center),
                          minVerticalPadding: 60,
                          subtitle: Text(
                              "يمكنك بسهولة حجز مواعيدك في من المراكز ومتابعتها.",
                              style: TextStyle(
                                  color: Color(0xff807788),
                                  fontFamily: "Tajawal",
                                  fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  //4
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 190, right: 60, left: 100),
                          child: Image.asset(
                            "images/Wallet-amico.png",

                            // width: 400,
                            // height: 400,
                          ),
                        ),
                        ListTile(
                          title: Text(" الدفع ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 36, 65),
                                  fontFamily: "Tajawal",
                                  fontSize: 30),
                              textAlign: TextAlign.center),
                          minVerticalPadding: 50,
                          subtitle: Text("يمكنك الدفع بطريقة التي تريدها.",
                              style: TextStyle(
                                  color: Color(0xff807788),
                                  fontFamily: "Tajawal",
                                  fontSize: 20),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  )
                ]),

//**********************************************************************************/
//**********************************************************************************/
//**********************************************************************************/

                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                      alignment: Alignment.center,
                      // margin: EdgeInsets.symmetric(horizontal: 50),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        color: Color(0xFFEAE0EE),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                        child: Text("تسجيل الدخول ",
                            style: TextStyle(
                                fontFamily: "Tajawal",
                                fontSize: 30,
                                color: Color(0XFFB39DDB),
                                fontWeight: FontWeight.bold)),
                      )),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, bottom: 50),
                      // margin: EdgeInsets.symmetric(horizontal: 50),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SinUpPage()),
                          );
                        },
                        color: Color(0xFFEAE0EE),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 98, vertical: 10),
                        child: Text("انشاء حساب",
                            style: TextStyle(
                                fontFamily: "Tajawal",
                                fontSize: 30,
                                color: Color(0XFFB39DDB),
                                fontWeight: FontWeight.bold)),
                      )),
                ]),
              ]),
        ));
  }
}

//**********************************************************************************/
//**********************************************************************************/

