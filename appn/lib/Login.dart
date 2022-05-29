import 'package:appn/alert.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:appn/ProfilePersonly.dart';
import 'package:appn/Search.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:appn/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  bool _isObscure = true;
  String? Email, Fpassword;
  Login() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: "$Email", password: "$Fpassword");
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              // title: "خطأ",
              body: Text("لم يتم العثور على هذا البريد الإلكتروني.",
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 37, 142),
                      fontSize: 20,
                      fontFamily: "Tajawal")),
              animType: AnimType.RIGHSLIDE,
              dialogType: DialogType.WARNING,
              btnOkOnPress: () {},
              btnOkText: "حسنا",
              buttonsTextStyle: TextStyle(fontSize: 20, fontFamily: "Tajawal"),
              btnOkColor: Color.fromARGB(255, 83, 16, 97),
              padding:
                  EdgeInsets.only(bottom: 30, top: 30, left: 30, right: 30))
            ..show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              // title: "خطأ",
              body: Text(" الرقم السري غير صحيح.",
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 37, 142),
                      fontSize: 20,
                      fontFamily: "Tajawal")),
              animType: AnimType.RIGHSLIDE,
              dialogType: DialogType.ERROR,
              btnOkOnPress: () {},
              btnOkText: "حسنا",
              buttonsTextStyle: TextStyle(fontSize: 20, fontFamily: "Tajawal"),
              btnOkColor: Color.fromARGB(255, 83, 16, 97),
              padding:
                  EdgeInsets.only(bottom: 30, top: 30, left: 30, right: 30))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("not validate");
    }
  }
  //=====================================================================================================================================

  // صفحة تسجيل الدخول
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }),
        // brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 130,
        title: Text("تسجيل الدخول",
            style: TextStyle(
                color: Color.fromARGB(255, 14, 1, 21),
                fontFamily: "Tajawal",
                fontSize: 35)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
              gradient: LinearGradient(
                  colors: [Color(0xffEDE7F6), Color.fromRGBO(168, 148, 217, 0)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
      ),
      body: Stack(children: [
        Container(
          height: 1000,
          width: double.infinity,
          margin: EdgeInsets.only(top: 90),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white,Color(0xffEDE7F6)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(360), topRight: Radius.circular(0)),
          ),
        ),
        ListView(physics: BouncingScrollPhysics(), children: [
          Stack(children: [
            Form(
              key: formstate,
              child: Column(children: [
                // البريد الالكتروني
                Container(
                  padding: const EdgeInsets.fromLTRB(70, 200, 20, 0),
                  child: TextFormField(
                    onSaved: (val) {
                      Email = val;
                    },
                    validator: (Email) {
                      if (Email == null || Email.isEmpty)
                        return 'الرجاء عدم تركه فارغا.';
                      String pattern = r'\w+@\w+\.\w+';
                      if (!RegExp(pattern).hasMatch(Email))
                        return 'الرجاء كتابة البريد الالكتروني صحيح';
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Color.fromARGB(255, 118, 114, 114),
                    // controller: passwordController,
                    onChanged: (value) {
                      Email = value;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'البريد الالكتروني',
                      labelStyle: TextStyle(
                        fontFamily: "El_Messiri",
                        fontSize: 20,
                        color: Color.fromARGB(255, 118, 114, 114),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 118, 114, 114))),
                    ),
                  ),
                ),

                //  كلمة المرور
                Container(
                  padding: const EdgeInsets.fromLTRB(70, 20, 20, 2),
                  child: TextFormField(
                    onSaved: (val) {
                      Fpassword = val;
                    },
                    validator: (Fpassword) {
                      if (Fpassword == null || Fpassword.isEmpty)
                        return 'الرجاء عدم تركه فارغا.';
                    },
                    cursorColor: Color.fromARGB(255, 118, 114, 114),
                    obscureText: _isObscure,
                    // controller: passwordController,
                    onChanged: (value) {
                      Fpassword = value;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Color.fromARGB(255, 118, 114, 114),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF707070))),
                      labelText: ' كلمة المرور',
                      labelStyle: TextStyle(
                        fontFamily: "El_Messiri",
                        fontSize: 20,
                        color: Color.fromARGB(255, 118, 114, 114),
                        //textBaseline: ,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xff634074),
                      )),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 200, bottom: 50, top: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => forgotPassword()),
                      );
                      //forgot password screen
                    },
                    child: const Text(
                      'هل نسيت كلمة المرور؟',
                      style: TextStyle(
                        fontFamily: "Tajawal",
                        color: Color.fromARGB(255, 90, 27, 145),
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    // margin: EdgeInsets.symmetric(horizontal: 50),
                    child: MaterialButton(
                      onPressed: () async {
                        var user = await Login();
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profilepersonly()),
                          );
                        }
                      },
                      color: Color(0xff9575CD),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: Text("تسجيل الدخول",
                          style: TextStyle(
                              fontFamily: "Tajawal",
                              fontSize: 25,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold)),
                    )),
              ]),
            )
          ])
        ]),
      ]),
      backgroundColor: Colors.white,
      // Colors.deepPurple[50], //background color of all page
    );
  }
}
//.................................................................................
//.................................................................................

class forgotPassword extends StatefulWidget {
  forgotPassword({Key? key}) : super(key: key);

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String? Email;
  Future resetPassword() async {
    try {
      showLoading(context);
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.of(context).pop();
      AwesomeDialog(
          context: context,
          // title: "خطأ",
          body: Text(" تحقق من بريدك الالكتروني",
              style: TextStyle(
                  color: Color.fromARGB(255, 146, 37, 142),
                  fontSize: 20,
                  fontFamily: "Tajawal")),
          animType: AnimType.TOPSLIDE,
          dialogType: DialogType.SUCCES,
          btnOkOnPress: () {},
          btnOkText: "حسنا",
          buttonsTextStyle: TextStyle(fontSize: 20, fontFamily: "Tajawal"),
          btnOkColor: Color.fromARGB(255, 83, 16, 97),
          padding: EdgeInsets.only(bottom: 30, top: 30, left: 30, right: 30))
        ..show();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            // title: "خطأ",
            body: Text("لم يتم العثور على هذا البريد الإلكتروني.",
                style: TextStyle(
                    color: Color.fromARGB(255, 146, 37, 142),
                    fontSize: 20,
                    fontFamily: "Tajawal")),
            animType: AnimType.RIGHSLIDE,
            dialogType: DialogType.WARNING,
            btnOkOnPress: () {},
            btnOkText: "حسنا",
            buttonsTextStyle: TextStyle(fontSize: 20, fontFamily: "Tajawal"),
            btnOkColor: Color.fromARGB(255, 83, 16, 97),
            padding: EdgeInsets.only(bottom: 30, top: 30, left: 30, right: 30))
          ..show();
      }
    } catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
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
        title: Text("كلمة المرور",
            style: TextStyle(
                color: Color.fromARGB(255, 14, 1, 21),
                fontFamily: "Tajawal",
                fontSize: 35)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
              gradient: LinearGradient(
                  colors: [Color(0xffEDE7F6), Colors.white],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.white,
                Color(0xffEDE7F6),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(360), topRight: Radius.circular(0)),
            ),
          ),
          ListView(
            children: [
              Form(
                key: formstate,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(70, 250, 20, 0),
                      child: TextFormField(
                        controller: emailController,
                        onSaved: (val) {
                          Email = val;
                        },
                        validator: (Email) {
                          if (Email == null || Email.isEmpty)
                            return 'الرجاء عدم تركه فارغا.';
                          String pattern = r'\w+@\w+\.\w+';
                          if (!RegExp(pattern).hasMatch(Email))
                            return 'الرجاء كتابة البريد الالكتروني صحيح';
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color.fromARGB(255, 118, 114, 114),
                        // controller: passwordController,
                        onChanged: (value) {
                          Email = value;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'البريد الالكتروني',
                          labelStyle: TextStyle(
                            fontFamily: "El_Messiri",
                            fontSize: 20,
                            color: Color.fromARGB(255, 118, 114, 114),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 118, 114, 114))),
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 74, top: 50),
                        child: MaterialButton(
                          onPressed: () {
                            resetPassword();
                            // Future resetPassword() async {
                            //   await FirebaseAuth.instance.sendPasswordResetEmail(
                            //       email: emailController.text.trim());
                            // }
                            // AwesomeDialog(
                            //     context: context,
                            //     // title: "خطأ",
                            //     body: Text(
                            //         "     تم ارسال رابط لإعادة تعين كلمت \n   المرور",
                            //         style: TextStyle(
                            //             color: Color.fromARGB(255, 146, 37, 142),
                            //             fontSize: 20,
                            //             fontFamily: "Tajawal")),
                            //     animType: AnimType.RIGHSLIDE,
                            //     dialogType: DialogType.SUCCES,
                            //     btnOkOnPress: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => LoginPage()));
                            //     },
                            //     btnOkText: "الذهاب الى صفحة تسجيل الدخول",
                            //     buttonsTextStyle: TextStyle(
                            //         fontSize: 15, fontFamily: "Tajawal"),
                            //     btnOkColor: Color.fromARGB(255, 83, 16, 97),
                            //     padding: EdgeInsets.only(bottom: 30, top: 30))
                            //   ..show();
                          },
                          color: Color(0xFF8A56AC),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          child: Text("ارسال",
                              style: TextStyle(
                                  fontFamily: "Tajawal",
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold)),
                        )),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
