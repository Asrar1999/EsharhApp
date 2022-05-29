import 'package:appn/Login.dart';
import 'package:appn/alert.dart';
import 'package:appn/all.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appn/Verification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SinUpPage extends StatefulWidget {
  const SinUpPage({Key? key}) : super(key: key);
  State<StatefulWidget> createState() {
    return SinUpPageState();
  }
}

// //**********************************************************************************/

// // صفحة التسجيل

class SinUpPageState extends State<SinUpPage> {
  // Map<String, String> fieldValues = {};
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;

  TextEditingController dateinput = TextEditingController();
  SinUp2() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      AwesomeDialog(
          context: context,
          // title: "خطأ",
          body: Column(
            children: [
              Text("  تم ارسال رسالة تاكيدالى بريدك الالكتروني .",
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 37, 142),
                      fontSize: 20,
                      fontFamily: "Tajawal")),
            ],
          ),
          animType: AnimType.RIGHSLIDE,
          dialogType: DialogType.SUCCES,
          btnOkOnPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          btnOkText: "تسجيل الدخول",
          buttonsTextStyle: TextStyle(fontSize: 20, fontFamily: "Tajawal"),
          btnOkColor: Color.fromARGB(255, 83, 16, 97),
          padding: EdgeInsets.only(bottom: 30, top: 30, left: 30, right: 30))
        ..show();
    }
  }

  String? FName,
      LName,
      userName,
      Email,
      PhonNmber,
      Fpassword,
      Confirmpassword,
      password,
      formattedDate,
      PatientID;
  var seletedSex;
  bool _isObscure = true;

  sinUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: "$Email", password: "$Fpassword");
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              // title: "خطأ",
              body: Text("الايميل موجود سابقا",
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
              padding: EdgeInsets.only(bottom: 30, top: 30))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("not validate");
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
        title: Text("إنشاء الحساب",
            style: TextStyle(
                color: Color.fromARGB(255, 14, 1, 21),
                fontFamily: "Tajawal",
                fontSize: 35)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
              color: Colors.white
              // gradient: LinearGradient(
              //     colors: [Colors.white, Color.fromARGB(255, 168, 148, 217)],
              //     begin: Alignment.bottomCenter,
              //     end: Alignment.topCenter)
              ),
        ),
      ),
      body: Stack(children: [
        Container(
          height: 1000,
          width: double.infinity,
          margin: EdgeInsets.only(top: 80),
          decoration: BoxDecoration(
            color: Colors.white,
            // gradient: LinearGradient(
            //     colors: [Color.fromARGB(255, 168, 148, 217), Colors.white],
            //     begin: Alignment.bottomCenter,
            //     end: Alignment.topCenter),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(350), topRight: Radius.circular(0)),
          ),
        ),
//.............................................................................
//..............................................................................
        ListView(physics: BouncingScrollPhysics(), children: [
          Stack(
            children: [
              Form(
                key: formstate,
                child: Column(children: [
                  // الاسم الاول
                  Container(
                    padding: const EdgeInsets.fromLTRB(70, 100, 20, 0),
                    child: TextFormField(
                      onSaved: (val) {
                        FName = val;
                      },
                      cursorColor: Color(0xff634074),
                      // controller: passwordController,
                      onChanged: (value) {
                        FName = value;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_box_outlined,
                            color: Color.fromARGB(255, 118, 114, 114)),
                        border: UnderlineInputBorder(),
                        labelText: 'الاسم الاول',
                        labelStyle: TextStyle(
                          fontFamily: "El_Messiri",
                          fontSize: 20,
                          color: Color.fromARGB(255, 118, 114, 114),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff634074),
                        )),
                      ),
                      validator: (FName) {
                        if (FName == null || FName.isEmpty)
                          return 'الرجاء عدم تركه فارغا.';
                        return null;
                      },
                    ),
                  ),
                  // الاسم الثاني
                  Container(
                    padding: const EdgeInsets.fromLTRB(70, 2, 20, 0),
                    child: TextFormField(
                      cursorColor: Color(0xff634074),
                      // controller: passwordController,
                      onChanged: (value) {
                        LName = value;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_box_outlined,
                            color: Color.fromARGB(255, 118, 114, 114)),
                        border: UnderlineInputBorder(),
                        labelText: 'الاسم الثاني',
                        labelStyle: TextStyle(
                          fontFamily: "El_Messiri",
                          fontSize: 20,
                          color: Color.fromARGB(255, 118, 114, 114),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff634074),
                        )),
                      ),
                      validator: (LName) {
                        if (LName == null || LName.isEmpty)
                          return 'الرجاء عدم تركه فارغا.';
                        return null;
                      },
                      onSaved: (val) {
                        LName = val;
                      },
                    ),
                  ),
                  // البريد الالكتروني
                  Container(
                    padding: const EdgeInsets.fromLTRB(70, 2, 20, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Color(0xff634074),
                      // controller: passwordController,
                      onChanged: (value) {
                        Email = value;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email_outlined,
                            color: Color.fromARGB(255, 118, 114, 114)),
                        border: UnderlineInputBorder(),
                        labelText: 'البريد الالكتروني',
                        labelStyle: TextStyle(
                          fontFamily: "El_Messiri",
                          fontSize: 20,
                          color: Color.fromARGB(255, 118, 114, 114),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff634074),
                        )),
                      ),
                      validator: (Email) {
                        if (Email == null || Email.isEmpty)
                          return 'الرجاء عدم تركه فارغا.';
                        String pattern = r'\w+@\w+\.\w+';
                        if (!RegExp(pattern).hasMatch(Email))
                          return 'الرجاء كتابة البريد الالكتروني صحيح';
                        return null;
                      },
                      onSaved: (val) {
                        Email = val;
                      },
                    ),
                  ),
                  // رقم الهاتف
                  Container(
                    padding: const EdgeInsets.fromLTRB(70, 2, 20, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: Color(0xff634074),
                      // controller: passwordController,
                      onChanged: (value) {
                        PhonNmber = value;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone_iphone_outlined,
                            color: Color.fromARGB(255, 118, 114, 114)),
                        border: UnderlineInputBorder(),
                        labelText: 'رقم الهاتف',
                        labelStyle: TextStyle(
                          fontFamily: "El_Messiri",
                          fontSize: 20,
                          color: Color.fromARGB(255, 118, 114, 114),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff634074),
                        )),
                      ),
                      validator: (PhonNmber) {
                        if (PhonNmber == null || PhonNmber.isEmpty)
                          return 'الرجاء عدم تركه فارغا.';
                        return null;
                      },
                      onSaved: (val) {
                        PhonNmber = val;
                      },
                    ),
                  ),
                  // كلمة المرور
                  Container(
                    padding: const EdgeInsets.fromLTRB(70, 2, 20, 2),
                    child: TextFormField(
                      cursorColor: Color(0xff634074),
                      obscureText: _isObscure,
                      // controller: passwordController,
                      onChanged: (value) {
                        Fpassword = value;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock_outlined,
                            color: Color.fromARGB(255, 118, 114, 114)),
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
                        labelText: 'كلمة المرور',
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
                      validator: (Fpassword) {
                        if (Fpassword == null || Fpassword.isEmpty)
                          return 'الرجاء عدم تركه فارغا.';
                        String pattern =
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                        if (!RegExp(pattern).hasMatch(Fpassword))
                          return 'يجب أن تتكون كلمة المرور من 8 أحرف وارقام على الأقل';
                        return null;
                      },
                      onSaved: (val) {
                        Fpassword = val;
                      },
                    ),
                  ),
                  //  تأكيد كلمة المرور
                  Container(
                    padding: const EdgeInsets.fromLTRB(70, 2, 20, 2),
                    child: TextFormField(
                      cursorColor: Color(0xff634074),
                      obscureText: _isObscure,
                      // controller: passwordController,
                      onChanged: (value) {
                        Confirmpassword = value;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock_outlined,
                            color: Color.fromARGB(255, 118, 114, 114)),
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
                        labelText: ' تأكيد كلمة المرور',
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
                      validator: (Confirmpassword) {
                        if (Confirmpassword == null || Confirmpassword.isEmpty)
                          return 'الرجاء عدم تركه فارغا.';
                        if (Fpassword != Confirmpassword)
                          return ' الرجاء من تطابق كلمات المرور';
                        return null;
                      },
                      onSaved: (val) {
                        Confirmpassword = val;
                      },
                    ),
                  ),
                  // // الميلاد
                  FormField(
                    builder: (state) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(70, 2, 20, 10),
                            child: TextField(
                                cursorColor: Color(0xff634074),
                                controller:
                                    dateinput, //editing controller of this TextField
                                decoration: InputDecoration(
                                  icon: Icon(Icons.calendar_today,
                                      color:
                                          Color.fromARGB(255, 118, 114, 114)),
                                  labelText:
                                      "تاريج الميلاد ", //label text of field
                                  labelStyle: TextStyle(
                                    fontFamily: "El_Messiri",
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 118, 114, 114),
                                  ),
                                ),
                                readOnly:
                                    true, //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1600),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy/MM/dd')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      dateinput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  }
                                }),
                          ),
                          Text(
                            state.errorText ?? '',
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            ),
                          )
                        ],
                      ); // Column
                    },
                  ),
                  // // //........................................................................................
                  // الجنس
                  Container(
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(right: 20, left: 70),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.people_outlined,
                            size: 30,
                            color: Color.fromARGB(255, 118, 114, 114)),
                      ),
                      iconEnabledColor: Color.fromARGB(255, 118, 114, 114),
                      iconSize: 30,
                      // underline: Divider(color:Color(0XFF707070),thickness: 1),
                      isExpanded: true,
                      hint: Text("الجنس",
                          style: TextStyle(
                            fontFamily: "El_Messiri",
                            color: Color.fromARGB(255, 118, 114, 114),
                            fontSize: 20,
                          )),
                      items: ["انثى", "ذكر"]
                          .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          seletedSex = val;
                        });
                      },
                      value: seletedSex,
                      onSaved: (val) {
                        seletedSex = val;
                      },
                    ),
                  ),

                  //..............................................................................................
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 50, bottom: 50),
                      child: MaterialButton(
                        onPressed: () async {
                          UserCredential response = await sinUp();
                          if (response != null) {
                            _firestore.collection('Patients').add({
                              'Birthday': dateinput.text,
                              'Fname': FName,
                              'Lname': LName,
                              'Patient email': Email,
                              'Patient phon': PhonNmber,
                              'Sex': seletedSex,
                              'PatientID':
                                  FirebaseAuth.instance.currentUser!.uid,
                            });
                            User? user = FirebaseAuth.instance.currentUser;

                            if (user != null && !user.emailVerified) {
                              user.sendEmailVerification();
                              SinUp2();
                            }
                          }
                        },
                        color: Color(0xff9575CD),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                        child: Text("إنشاء الحساب",
                            style: TextStyle(
                                fontFamily: "Tajawal",
                                fontSize: 30,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold)),
                      )),
                ]),
              ),
            ],
          ),
        ]), //),

        // Container(
        //     margin: EdgeInsets.only(top: 60, right: 340),
        //     child: IconButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       icon: Icon(Icons.arrow_back_ios_new),
        //       color: Color.fromARGB(255, 118, 114, 114),
        //       iconSize: 30,
        //     )),
      ]),
      backgroundColor: Color(0xffEDE7F6), //background color of all page
    );
  }
}
