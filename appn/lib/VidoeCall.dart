import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:appn/appBarian.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import 'package:agora_rtc_engine/src/rtc_remote_view.dart';


class VideoCallScreen extends StatefulWidget {
  VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late int _remoteUid = 0;
  late RtcEngine _engine;

  void initState() {
    super.initState();
    initAgora();
  }
@override
  void dispose() {
    _engine.leaveChannel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150.0),
                child: Container(
                    height: 150, width: 150, child: _renderLocalPreview()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, left: 350),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      icon: Icon(
                        Icons.call_end,
                        size: 44,
                        color: Colors.redAccent,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.create(AgoraManager.appId);
    _engine.enableVideo();
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        print("‘local user $uid joined successfully’");
      },
      userJoined: (int uid, int elapsed) {
// player.stop();
        print("‘remote user $uid joined successfully’");
        setState(() => _remoteUid = uid);
      },
      userOffline: (int uid, UserOfflineReason reason) {
        print("‘remote user $uid left call’");
        setState(() => _remoteUid = 0);
        Navigator.of(context).pop(true);
      },
    ));
    await _engine.joinChannel(
        AgoraManager.token, AgoraManager.channelName, null, 0);
  }

Widget _renderLocalPreview() {
return RtcLocalView.SurfaceView();
}
//remote User View


Widget _renderRemoteVideo() {
if (_remoteUid != 0) {
return RtcRemoteView.SurfaceView(uid: _remoteUid);
} else {
return Text(
"يتصل...",
style: Theme.of(context).textTheme.headline6,
textAlign: TextAlign.center,
);
}
}
}
