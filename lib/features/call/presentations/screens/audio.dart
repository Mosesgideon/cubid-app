import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
class AudioCallScreen extends StatefulWidget {
  final String callID;
  final String userId;
  final String username;
  const AudioCallScreen({super.key, required this.callID, required this.username, required this.userId});

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  @override
  Widget build(BuildContext context) {
    return  ZegoUIKitPrebuiltCall(
      appID: 1505596156,
      appSign: '9872d79e944c78a0ddf42ed690b0de080d72e25f03271322b844d3f29f0fc87a', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: widget.userId,
      userName:  widget.username,
      callID: widget.callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
