import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
class VideoCallScreen extends StatefulWidget {
  final String callID;
  final String userID;
  final String userName;
  const VideoCallScreen({super.key, required this.callID, required this.userID, required this.userName});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1505596156,
      appSign: '9872d79e944c78a0ddf42ed690b0de080d72e25f03271322b844d3f29f0fc87a', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: widget.userID,
      userName: widget.userName,
      callID: widget.callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );

  }
}
