// import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:online/resources/auth_methods.dart';
import 'package:online/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  // var jitsiMeet = JitsiMeet();
  // var options = JitsiMeetConferenceOptions(room: 'jitsiIsAwesome');
  // JitsiMeetMethods.join(options);
  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = "",
  }) async {
    try {
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      var jitsiMeet = JitsiMeet();
      var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.jit.si",
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": false,
          "startWithVideoMuted": false,
          "subject": "Jitsi with Flutter",
        },
        featureFlags: {
          "unsaferoomwarning.enabled": false,
          "welcomePage.Enabled": false,
          "resolution": FeatureFlagVideoResolutions.resolution480p,
          "audio-mute.enabled": isAudioMuted,
          "video-mute.enabled": isVideoMuted,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );
      _firestoreMethods.addToMeeting(roomName);
      await jitsiMeet.join(options);
    } catch (e) {
      print("error: $e");
    }
  }
}
