import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_web/screens/createprofile.dart';
import 'package:insighteye_web/screens/homesrc.dart';
import 'package:insighteye_web/screens/restrictedsrc.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  User? user = FirebaseAuth.instance.currentUser;
  String? userType;
  String? orgId;
  String? photoUrl;
  @override
  void initState() {
    super.initState();
    String displayName = user?.displayName ?? '';
    if (user != null && displayName != "") {
      setState(() {
        userType = displayName.substring(0, 1);
        orgId = displayName.substring(1);
        photoUrl = user?.photoURL;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    if (userType == "S") {
      if (photoUrl != null) {
        return OfficeHome(
          orgId: orgId,
        );
      } else {
        return CreateProfileSrc(
          orgId: orgId,
        );
      }
    }
    return const RestricedSrc();
  }
}