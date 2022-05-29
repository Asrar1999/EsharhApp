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
import 'package:flutter/src/widgets/scroll_controller.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaiementPage extends StatefulWidget {
  PaiementPage({Key? key}) : super(key: key);

  @override
  State<PaiementPage> createState() => _PaiementPageState();
}

class _PaiementPageState extends State<PaiementPage>
    with TickerProviderStateMixin {
  // TickerProviderStateMixin allows the fade out/fade in animation when changing the active button

  // this will control the button clicks and tab changing
  late TabController _controller;

  // this will control the animation when a button changes from an off state to an on state
  late AnimationController _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  late AnimationController _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  late Animation _colorTweenBackgroundOn;
  Animation? _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  Animation? _colorTweenForegroundOn;
  Animation? _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  // these will be our tab icons. You can use whatever you like for the content of your buttons
  List _icons = [
    Icons.payments,
    Icons.credit_card,
  ];

  // active button's foreground color
  Color _foregroundOn = Colors.white;
  Color _foregroundOff = Color(0XFFBEBEBE);

  // active button's background color
  Color _backgroundOn = Color(0xff8A56AC);
  Color _backgroundOff = Color.fromARGB(255, 255, 255, 255);

  // scroll controller for the TabBar
  ScrollController _scrollController = new ScrollController();

  // this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  List _keys = [];

  // regist if the the button was tapped
  bool _buttonTap = false;

  @override
  void initState() {
    super.initState();

    for (int index = 0; index < _icons.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(new GlobalKey());
    }

    // this creates the controller with 6 tabs (in our case)
    _controller = TabController(vsync: this, length: _icons.length);
    // this will execute the function every time there's a swipe animation
    _controller.animation!.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller.addListener(_handleTabChange);

    _animationControllerOff =
        AnimationController(vsync: this, duration: Duration(milliseconds: 75));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);

    _animationControllerOn =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          toolbarHeight: 120,
          title: Text("الــدفــع",
              style: TextStyle(
                  color: Color.fromARGB(255, 14, 1, 21),
                  fontFamily: "Tajawal",
                  fontSize: 35)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80)),
                color: Colors.white
                // gradient: LinearGradient(
                //     colors: [Colors.white, Color.fromARGB(255, 168, 148, 217)],
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter)
                ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.black,
                  size: 30,
                ))
          ],
        ),
        backgroundColor: Color(0xffEDE7F6),
        body: Column(children: <Widget>[
          // this is the TabBar
          Container(
              margin: EdgeInsets.only(top: 50, right: 100),
              height: 49.0,
              // this generates our tabs buttons
              child: ListView.builder(
                  // this gives the TabBar a bounce effect when scrolling farther than it's size
                  physics: BouncingScrollPhysics(),
                  // controller: _scrollController,
                  // make the list horizontal
                  scrollDirection: Axis.horizontal,
                  // number of tabs
                  itemCount: _icons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        // each button's key
                        key: _keys[index],
                        // padding for the buttons
                        padding: EdgeInsets.all(6.0),
                        child: ButtonTheme(
                            child: AnimatedBuilder(
                          animation: _colorTweenBackgroundOn,
                          builder: (context, child) => MaterialButton(
                              // get the color of the button's background (dependent of its state)
                              color: _getBackgroundColor(index),
                              // make the button a rectangle with round corners
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              onPressed: () {
                                setState(() {
                                  _buttonTap = true;
                                  // trigger the controller to change between Tab Views
                                  _controller.animateTo(index);
                                  // set the current index
                                  _setCurrentIndex(index);
                                  // scroll to the tapped button (needed if we tap the active button and it's not on its position)
                                  _scrollTo(index);
                                });
                              },
                              child: Icon(
                                // get the icon
                                _icons[index],
                                // get the color of the icon (dependent of its state)
                                color: _getForegroundColor(index),
                              )),
                        )));
                  })),
          Flexible(
              // this will host our Tab Views
              child: TabBarView(
            // and it is controlled by the controller
            controller: _controller,
            children: <Widget>[
              // our Tab Views
              SdadPage(),
              PayPage(),
            ],
          )),
        ]));
  }

  // runs during the switching tabs animation
  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller.animation!.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller.index);

    // this resets the button tap
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn.reset();
    _animationControllerOff.reset();

    // run the animations!
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[_icons.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return _colorTweenBackgroundOn.value;
    } else if (index == _prevControllerIndex) {
      // if it's the previous active button
      return _colorTweenBackgroundOff!.value;
    } else {
      // if the button is inactive
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn!.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff!.value;
    } else {
      return _foregroundOff;
    }
  }
}

class PayPage extends StatefulWidget {
  PayPage({Key? key}) : super(key: key);

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String? NameInCard;
  String? NumInCard;
  String? DateOfCard;
  String? CssOfCard;
  final _firestore = FirebaseFirestore.instance;

  payment() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      AwesomeDialog(
          context: context,
          // title: "خطأ",
          body: Column(
            children: [
              Text(" تم الاشتراك بنجاح .",
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 37, 142),
                      fontSize: 20,
                      fontFamily: "Tajawal")),
            ],
          ),
          animType: AnimType.RIGHSLIDE,
          dialogType: DialogType.SUCCES,
          btnOkOnPress: () {},
          btnOkText: "الفواتير",
          buttonsTextStyle: TextStyle(fontSize: 20, fontFamily: "Tajawal"),
          btnOkColor: Color.fromARGB(255, 83, 16, 97),
          padding: EdgeInsets.only(bottom: 30, top: 30, left: 30, right: 30))
        ..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  Container(
                    height: 350,
                    width: 350,
                    margin: EdgeInsets.only(top: 60),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: TextFormField(
                            // keyboardType: TextInputType.number,
                            cursorColor: Color(0xff634074),
                            // controller: passwordController,
                            onChanged: (value) {
                              NameInCard = value;
                            },
                            decoration: const InputDecoration(
                              // icon: Icon(Icons.phone_iphone_outlined,
                              //     color: Color.fromARGB(255, 118, 114, 114)),
                              border: UnderlineInputBorder(),
                              labelText: 'الاسم في البطاقة',
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
                            validator: (NumInCard) {
                              if (NumInCard == null || NumInCard.isEmpty)
                                return 'الرجاء عدم تركه فارغا.';
                              return null;
                            },
                            onSaved: (val) {
                              NumInCard = val;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xff634074),
                            // controller: passwordController,
                            onChanged: (value) {
                              NumInCard = value;
                            },
                            decoration: const InputDecoration(
                              // icon: Icon(Icons.phone_iphone_outlined,
                              //     color: Color.fromARGB(255, 118, 114, 114)),
                              border: UnderlineInputBorder(),
                              labelText: 'رقـم الـبـطـاقـة',
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
                            validator: (NumInCard) {
                              if (NumInCard == null || NumInCard.isEmpty)
                                return 'الرجاء عدم تركه فارغا.';
                              return null;
                            },
                            onSaved: (val) {
                              NumInCard = val;
                            },
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 25, 160, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                cursorColor: Color(0xff634074),
                                // controller: passwordController,
                                onChanged: (value) {
                                  DateOfCard = value;
                                },
                                decoration: const InputDecoration(
                                  // icon: Icon(Icons.phone_iphone_outlined,
                                  //     color: Color.fromARGB(255, 118, 114, 114)),
                                  border: UnderlineInputBorder(),
                                  labelText: 'تاريخ البطاقة ',
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
                                validator: (DateOfCard) {
                                  if (DateOfCard == null || DateOfCard.isEmpty)
                                    return 'الرجاء عدم تركه فارغا.';
                                  return null;
                                },
                                onSaved: (val) {
                                  DateOfCard = val;
                                },
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(190, 25, 20, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0xff634074),
                                // controller: passwordController,
                                onChanged: (value) {
                                  CssOfCard = value;
                                },
                                decoration: const InputDecoration(
                                  // icon: Icon(Icons.phone_iphone_outlined,
                                  //     color: Color.fromARGB(255, 118, 114, 114)),
                                  border: UnderlineInputBorder(),
                                  labelText: 'رمز الامان  ',
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
                                validator: (CssOfCard) {
                                  if (CssOfCard == null || CssOfCard.isEmpty)
                                    return 'الرجاء عدم تركه فارغا.';
                                  return null;
                                },
                                onSaved: (val) {
                                  CssOfCard = val;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () async {
                        payment();
                        _firestore.collection('Card information').add({
                          'NameIn Card;': NameInCard,
                          'NumIn Card;': NumInCard,
                          'DateOf Card': DateOfCard,
                          ' CssOfCard;': CssOfCard,
                          'PatientID': FirebaseAuth.instance.currentUser!.uid,
                        });
                      },
                      child: Text(
                        "أكمل الدفع",
                        style: TextStyle(fontSize: 20, fontFamily: "Tajawal"),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          primary: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffEDE7F6),
    );
  }
}

/* ===========================================================================================
==============================================================================================
================================================================================================
 */
class SdadPage extends StatefulWidget {
  SdadPage({Key? key}) : super(key: key);

  @override
  State<SdadPage> createState() => _SdadPageState();
}

class _SdadPageState extends State<SdadPage> {
  payment() async {
    AwesomeDialog(
        context: context,
        // title: "خطأ",
        body: Column(
          children: [
            Text(" تم الاشتراك بنجاح .",
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
            MaterialPageRoute(builder: (context) => profilePage1()),
          );
        },
        btnOkText: "المواعيد",
        buttonsTextStyle: TextStyle(fontSize: 20, fontFamily: "Tajawal"),
        btnOkColor: Color.fromARGB(255, 83, 16, 97),
        padding: EdgeInsets.only(bottom: 30, top: 30, left: 30, right: 30))
      ..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                  // height: 300,
                  // width: 350,
                  margin: EdgeInsets.only(top: 50, left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Image.asset("images/123.png"),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: ListTile(
                          title: Text("رقم الفاتورة ",
                              style: TextStyle(
                                color: Color(0xffA584B5),
                                fontSize: 20,
                                fontFamily: "Tajawal",
                              )),
                          subtitle: Text("0100000000000",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Tajawal",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      payment();
                    },
                    child: Text(
                      "أكمل الدفع",
                      style: TextStyle(fontSize: 20, fontFamily: "Tajawal"),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        primary: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffEDE7F6),
    );
  }
}
