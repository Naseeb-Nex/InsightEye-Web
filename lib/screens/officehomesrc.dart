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
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 60,
            width: 120,
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color:const Color(0XFF793BA8),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 20,
                    color: secondbg.withOpacity(0.20),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: ListView(


                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset("assets/icons/appicon.png", width: 60, height: 68,),
                    const SizedBox(
                      height: 100,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => setState(() {
                            currentscr = 'Home';
                          }),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: currentscr == 'Home' ? Image.asset("assets/icons/shome.png") : Image.asset("assets/icons/home.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            currentscr = 'View';
                          }),
                         child: SizedBox(
                            height: 30,
                            width: 30,
                            child: currentscr == 'View' ? Image.asset("assets/icons/hfile.png") : Image.asset("assets/icons/file.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            currentscr = 'customer';
                          }),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: currentscr == 'customer' ? Image.asset("assets/icons/scust.png") : Image.asset("assets/icons/cust.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            currentscr = 'customerreg';
                          }),
                          child: SizedBox(
                            height: 35,
                            width: 35,
                            child: currentscr == 'customerreg' ? Image.asset("assets/icons/saddcust.png") : Image.asset("assets/icons/addcust.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            currentscr = 'vehicleportal';
                          }),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: currentscr == 'vehicleportal' ? Image.asset("assets/icons/sscoot.png") : Image.asset("assets/icons/sscoot.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            currentscr = 'report';
                          }),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: currentscr == 'report' ? Image.asset("assets/icons/sgraph.png") : Image.asset("assets/icons/graph.png"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.only(right: 10, top: 10, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0XFFf8fafb),
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
