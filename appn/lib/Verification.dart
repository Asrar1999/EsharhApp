// // import 'package:flutter/material.dart';
// // import 'package:flutter_verification_code/flutter_verification_code.dart';
// // import 'package:appn/ProfilePersonly.dart';

// // class VerificationPage extends StatefulWidget {
// //   State<StatefulWidget> createState() {
// //     return VerificationPageState();
// //   }
// // }

// // // صفحة التحقق
// // class VerificationPageState extends State<VerificationPage> {
// //   static String _code = "/otp";
// //   static bool _onEditing = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //         leading: Builder(builder: (BuildContext context) {
// //           return IconButton(
// //             icon: const Icon(
// //               Icons.arrow_back_ios_outlined,
// //               color: Colors.black,
// //               size: 30,
// //             ),
// //             onPressed: () {
// //               Navigator.pop(context);
// //             },
// //           );
// //         }),
// //         // brightness: Brightness.dark,
// //         backgroundColor: Colors.transparent,
// //         elevation: 0.0,
// //         toolbarHeight: 130,
// //         title: Text("إنشاء الحساب",
// //             style: TextStyle(
// //                 color: Color.fromARGB(255, 14, 1, 21),
// //                 fontFamily: "Tajawal",
// //                 fontSize: 35)),
// //         centerTitle: true,
// //         flexibleSpace: Container(
// //           decoration: BoxDecoration(
// //               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
// //               gradient: LinearGradient(
// //                   colors: [Colors.white, Color.fromARGB(255, 168, 148, 217)],
// //                   begin: Alignment.bottomCenter,
// //                   end: Alignment.topCenter)),
// //         ),
// //       ),
// //       body: Stack(
// //         children: [
// //           Center(
// //             child: Container(
// //               margin: EdgeInsets.only(top: 100),
// //               child: VerificationCode(
// //                 textStyle: TextStyle(
// //                     fontSize: 20.0, color: Color.fromARGB(255, 107, 8, 102)),
// //                 keyboardType: TextInputType.number,
// //                 underlineColor: Color(
// //                     0xffF3E5F5), // If this is null it will use primaryColor: Colors.red from Theme
// //                 length: 4,
// //                 cursorColor: Color.fromARGB(255, 107, 8,
// //                     102), // If this is null it will default to the ambient
// //                 fillColor: Color.fromARGB(255, 107, 8, 102),
// //                 clearAll: Padding(
// //                   padding: const EdgeInsets.only(top: 40),
// //                   child: Text(
// //                     'امسح ',
// //                     style: TextStyle(
// //                       fontFamily: "Tajawal",
// //                         fontSize: 20.0,
// //                         decoration: TextDecoration.underline,
// //                         color: Color.fromARGB(255, 90, 27, 145),),
// //                   ),
// //                 ),
// //                 onCompleted: (String value) {
// //                   setState(() {
// //                     _code = value;
// //                   });
// //                 },
// //                 onEditing: (bool value) {
// //                   setState(() {
// //                     _onEditing = value;
// //                   });
// //                   if (!_onEditing) FocusScope.of(context).unfocus();
// //                 },
// //               ),
// //             ),
// //           ),
// //           // Container(
// //           //   margin: EdgeInsets.only(bottom: 100),
// //           //   child: Center(
// //           //     child: (_onEditing != true)
// //           //         ? Text('')
// //           //         : Text(
// //           //             'الرجاء ادخال الكود',
// //           //             style: TextStyle(
// //           //                 fontSize: 20.5,
// //           //                 color: Color.fromARGB(255, 107, 8, 102)),
// //           //           ),
// //           //   ),
// //           // ),
// // // //..................................................................................................
// // //................................................................................................................
// //           Container(
// //               alignment: Alignment.center,
// //               // margin: EdgeInsets.only(top: 20),
// //               child: MaterialButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => Profilepersonly()),
// //                   );
// //                 },
// //                 color: Color.fromARGB(255, 46, 1, 76),
// //                 shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(30)),
// //                 padding: EdgeInsets.symmetric(horizontal: 60,vertical:10 ),
// //                 child: Text("تأكيد",
// //                     style: TextStyle(
// //                       fontFamily: "Tajawal",
// //                         fontSize: 30,
// //                         color: Color.fromARGB(255, 255, 255, 255),
// //                         fontWeight: FontWeight.bold)),
// //               )),
// //         ],
// //       ),

// //       backgroundColor: Colors.deepPurple[50], //background color of all page
// //     );
// //   }
// // }
// //Agora stuff
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // replace with your App ID from Agora.io
// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class Chart extends StatefulWidget {
//   @override
//   _ChartState createState() => _ChartState();
// }

// class _ChartState extends State<Chart> {

//   List<charts.Series<Task, String>> _seriesPieData;
//   _generateData(){
//     var pieData = [
//       new Task(task: 'Tam', taskvalue: 25, colorval: Colors.green),
//       new Task(task: 'Spencer', taskvalue: 25, colorval: Colors.blue),
//       new Task(task: 'Harry', taskvalue: 25, colorval: Colors.red),
//       new Task(task: 'Jeremy', taskvalue: 25, colorval: Colors.purple),
//     ];

//     _seriesPieData.add(
//       charts.Series(
//         data: pieData,
//         domainFn: (Task task,_)=> task.task,
//         measureFn: (Task task,_)=> task.taskvalue,
//         id: "Work Spilted on App",
//         labelAccessorFn: (Task row,_)=>'${row.taskvalue}',
//       )
//     ); 
//   }

//   @override
//   void initState() {
//     super.initState();
//     _seriesPieData = List<charts.Series<Task, String>>();
//     _generateData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 1,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.green,
//             bottom: TabBar(
//               tabs: [Tab(icon: Icon(FontAwesomeIcons.chartPie))],
//             ),
//             title: Text('Chat Anayltics'),
//           ),
//           body: TabBarView(
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Container(
//                   child: Center(
//                     child: Column(
//                       children: <Widget>[
//                         Text('Time spent on the project', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
//                         SizedBox(height: 10.0,),
//                         Expanded(
//                           child: charts.PieChart(
//                             _seriesPieData,
//                             animate: true,
//                             animationDuration: Duration(seconds: 3),
//                             behaviors: [
//                               new charts.DatumLegend(
//                                 outsideJustification: charts.OutsideJustification.endDrawArea,
//                                 horizontalFirst: false,
//                                 desiredMaxRows: 2,
//                                 cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
//                                 entryTextStyle: charts.TextStyleSpec(
//                                   color: charts.MaterialPalette.green.shadeDefault,
//                                   fontFamily: 'Georgia',
//                                   fontSize: 12
//                                 ),
//                               )
//                             ],
//                             defaultRenderer: new charts.ArcRendererConfig(
//                               arcWidth: 100,
//                               arcRendererDecorators: [
//                                 new charts.ArcLabelDecorator(labelPosition: charts.ArcLabelPosition.inside)
//                               ]
//                             )
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed:(){
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class Task{
//   String task;
//   double taskvalue;
//   MaterialColor colorval;

//   Task({this.task, this.taskvalue, this.colorval});
// }
// const APP_ID = "example";

// class VideoRoom extends StatefulWidget {
//   /// non-modifiable channel name of the page
//   final String groupId;

//   /// Creates a call page with given channel name.
//   const VideoRoom({Key? key, required this.groupId}) : super(key: key);

//   @override
//   VideoRoomState createState() {
//     return new VideoRoomState();
//   }
// }

// class VideoRoomState extends State<VideoRoom>{
  
//   static final _users = List<int>();
//   final _infoStrings = <String>[];
//   bool muted = false;

//   @override
//   void dispose() {
//     // clear users
//     _users.clear();
//     // destroy sdk
//     AgoraRtcEngine.leaveChannel();
//     AgoraRtcEngine.destroy();
//     super.dispose();
//   }

//   @override
//   void initState(){
//     super.initState();
//     init();
//   }

//   // initialize agora sdk
//   init() async{
//     initialize();
//   }

//   void initialize() {
//     if (APP_ID.isEmpty) {
//       setState(() {
//         _infoStrings
//             .add("APP_ID missing, please provide your APP_ID in settings.dart");
//         _infoStrings.add("Agora Engine is not starting");
//       });
//       return;
//     }

//     _initAgoraRtcEngine();
//     _addAgoraEventHandlers();
//     AgoraRtcEngine.enableWebSdkInteroperability(true);
//     // set parameters for Agora Engine
//     AgoraRtcEngine.setParameters('{\"che.video.lowBitRateStreamParameter\"'
//     +':{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}');
//     // join channel corresponding to current group
//     AgoraRtcEngine.joinChannel(null, widget.groupId, null, 0);
//   }

//   /// Create agora sdk instance and initialze
//   Future<void> _initAgoraRtcEngine() async {
//     AgoraRtcEngine.create(APP_ID);
//     AgoraRtcEngine.enableVideo();
//   }

//   /// Add agora event handlers
//   void _addAgoraEventHandlers() {
//     AgoraRtcEngine.onError = (dynamic code) {
//       setState(() {
//         String info = 'onError: ' + code.toString();
//         _infoStrings.add(info);
//       });
//     };

//     AgoraRtcEngine.onJoinChannelSuccess =
//         (String channel, int uid, int elapsed) {
//       setState(() {
//         String info = 'onJoinChannel: ' + channel + ', uid: ' + uid.toString();
//         _infoStrings.add(info);
//       });
//     };

//     AgoraRtcEngine.onLeaveChannel = () {
//       setState(() {
//         _infoStrings.add('onLeaveChannel');
//         _users.clear();
//       });
//     };

//     AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
//       setState(() {
//         String info = 'userJoined: ' + uid.toString();
//         _infoStrings.add(info);
//         _users.add(uid);
//       });
//     };

//     AgoraRtcEngine.onUserOffline = (int uid, int reason) {
//       setState(() {
//         String info = 'userOffline: ' + uid.toString();
//         _infoStrings.add(info);
//         _users.remove(uid);
//       });
//     };

//     AgoraRtcEngine.onFirstRemoteVideoFrame =
//         (int uid, int width, int height, int elapsed) {
//       setState(() {
//         String info = 'firstRemoteVideo: ' +
//             uid.toString() +
//             ' ' +
//             width.toString() +
//             'x' +
//             height.toString();
//         _infoStrings.add(info);
//       });
//     };
//   }

//   /// Helper function to get list of native views
//   List<Widget> _getRenderViews() {
//     List<Widget> list = [AgoraRenderWidget(0, local: true, preview: true)];
//     _users.forEach((int uid) => {
//       list.add(AgoraRenderWidget(uid))
//     });
//     return list;
//   }

//   /// Video view wrapper
//   Widget _videoView(view) {
//     return Expanded(child: Container(child: view));
//   }

//   /// Video view row wrapper
//   Widget _expandedVideoRow(List<Widget> views) {
//     List<Widget> wrappedViews =
//         views.map((Widget view) => _videoView(view)).toList();
//     return Expanded(
//       child: Row(
//         children: wrappedViews,
//       )
//     );
//   }

//   /// Video layout wrapper
//   Widget _viewRows() {
//     List<Widget> views = _getRenderViews();
//     switch (views.length) {
//       case 1:
//         return Container(
//             child: Column(
//           children: <Widget>[_videoView(views[0])],
//         ));
//       case 2:
//         return Container(
//             child: Column(
//           children: <Widget>[
//             _expandedVideoRow([views[0]]),
//             _expandedVideoRow([views[1]])
//           ],
//         ));
//       case 3:
//         return Container(
//             child: Column(
//           children: <Widget>[
//             _expandedVideoRow(views.sublist(0, 2)),
//             _expandedVideoRow(views.sublist(2, 3))
//           ],
//         ));
//       case 4:
//         return Container(
//             child: Column(
//           children: <Widget>[
//             _expandedVideoRow(views.sublist(0, 2)),
//             _expandedVideoRow(views.sublist(2, 4))
//           ],
//         ));
//       default:
//     }
//     return Container();
//   }

//   /// Toolbar layout
//   Widget _toolbar() {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Container(
//             alignment: Alignment.topRight,
//             padding: EdgeInsets.symmetric(vertical: 48),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 RawMaterialButton(
//                   onPressed: () => _onToggleMute(),
//                   child: new Icon(
//                     muted ? Icons.mic : Icons.mic_off,
//                     color: muted ? Colors.white : Colors.blueAccent,
//                     size: 20.0,
//                   ),
//                   shape: new CircleBorder(),
//                   elevation: 2.0,
//                   fillColor: muted ? Colors.blueAccent : Colors.white,
//                   padding: const EdgeInsets.all(12.0),
//                 ),
//                 RawMaterialButton(
//                   onPressed: () => _onSwitchCamera(),
//                   child: new Icon(
//                     Icons.switch_camera,
//                     color: Colors.blueAccent,
//                     size: 20.0,
//                   ),
//                   shape: new CircleBorder(),
//                   elevation: 2.0,
//                   fillColor: Colors.white,
//                   padding: const EdgeInsets.all(12.0),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Info panel to show logs
//   Widget _panel() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 48),
//       alignment: Alignment.bottomCenter,
//       child: FractionallySizedBox(
//         heightFactor: 0.5,
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 48),
//           child: ListView.builder(
//             reverse: true,
//             itemCount: _infoStrings.length,
//             itemBuilder: (BuildContext context, int index) {
//               if (_infoStrings.length == 0) {
//                 return null;
//               }
//               return Padding(
//                 padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min, 
//                   children: [
//                     Flexible(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 2, horizontal: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.yellowAccent,
//                           borderRadius: BorderRadius.circular(5)),
//                         child: Text(
//                           _infoStrings[index],
//                           style:TextStyle(color: Colors.blueGrey)
//                         )
//                       )
//                     )
//                   ]
//                 )
//               );
//             }
//           )
//         ),
//       )
//     );
//   }

//   void _onCallEnd(BuildContext context) {
//     Navigator.pop(context);
//   }

//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     AgoraRtcEngine.muteLocalAudioStream(muted);
//   }

//   void _onSwitchCamera() {
//     AgoraRtcEngine.switchCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           //uncomment _panel for debugging
//           children: <Widget>[_viewRows(), _toolbar()],
//         )
//       )
//     );
//   }
// }