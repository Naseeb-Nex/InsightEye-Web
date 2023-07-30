import 'package:flutter/material.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:insighteye_web/widgets/Reportsrcwidget.dart';
import 'package:insighteye_web/widgets/export_widget.dart';
import 'package:insighteye_web/widgets/vehicleportal_widget.dart';

// ignore: must_be_immutable
class OfficeHome extends StatefulWidget {
  String? orgId;
  OfficeHome({Key? key, this.orgId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OfficeHomeState createState() => _OfficeHomeState();
}

class _OfficeHomeState extends State<OfficeHome> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    String displayName = user?.displayName ?? '';
    if (user != null && displayName != "") {
      setState(() {
        widget.orgId = displayName.substring(1);
      });
    }
  }

  String? currentscr = "Home";

  @override
  Widget build(BuildContext context) {
    //  Responsive Size
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0XFFFAFBFF),
      body: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(s.width * 0.0093),
            child: Container(
              height: s.height - 24,
              width: s.width * 0.0667,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0XFF9643D6),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 20,
                    color: secondbg.withOpacity(0.20),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/appicon.png",
                      width: 40,
                      height: 48,
                    ),
                    SizedBox(height: s.height * 0.1),
                    SizedBox(
                      height: s.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'Home';
                            }),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: currentscr == 'Home'
                                  ? Image.asset(
                                      "assets/icons/shome.png",
                                      color: white,
                                    )
                                  : Image.asset(
                                      "assets/icons/home.png",
                                      color: white,
                                    ),
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'View';
                            }),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: currentscr == 'View'
                                  ? Image.asset(
                                      "assets/icons/sfile.png",
                                      color: white,
                                    )
                                  : Image.asset(
                                      "assets/icons/file.png",
                                      color: white,
                                    ),
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'customer';
                            }),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: currentscr == 'customer'
                                  ? Image.asset(
                                      "assets/icons/scust.png",
                                      color: white,
                                    )
                                  : Image.asset(
                                      "assets/icons/cust.png",
                                      color: white,
                                    ),
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'customerreg';
                            }),
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: currentscr == 'customerreg'
                                  ? Image.asset(
                                      "assets/icons/saddcust.png",
                                      color: white,
                                    )
                                  : Image.asset(
                                      "assets/icons/addcust.png",
                                      color: white,
                                    ),
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'vehicleportal';
                            }),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: currentscr == 'vehicleportal'
                                  ? Image.asset(
                                      "assets/icons/svan.png",
                                      color: white,
                                    )
                                  : Image.asset(
                                      "assets/icons/van.png",
                                      color: white,
                                    ),
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'report';
                            }),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: currentscr == 'report'
                                  ? Image.asset(
                                      "assets/icons/srep.png",
                                      color: white,
                                    )
                                  : Image.asset(
                                      "assets/icons/rep.png",
                                      color: white,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding:  EdgeInsets.only(right: s.width * 0.0093, top: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                // child: Pgmreg(uid: user!.uid),
                child: Widgetwrapper(
                  src: currentscr,
                  orgId: widget.orgId,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Widgetwrapper extends StatelessWidget {
  final String? src;
  final String? orgId;
  const Widgetwrapper({Key? key, this.src, this.orgId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (src == 'customer') {
      return Customersrc(orgId: orgId);
    } else if (src == 'customerreg') {
      return Customerreg(orgId: orgId);
    } else if (src == 'View') {
      return Pgmviewer(orgId: orgId);
    } else if (src == 'vehicleportal') {
      return VehiclePortalWidget(orgId: orgId);
    } else if (src == 'report') {
      return Reportsrcwidget(orgId: orgId);
    }
    return Homewidget(orgId: orgId);
  }
}
