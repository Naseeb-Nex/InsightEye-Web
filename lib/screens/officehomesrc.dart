import 'package:flutter/material.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:insighteye_web/widgets/Reportsrcwidget.dart';
import 'package:insighteye_web/widgets/export_widget.dart';
import 'package:insighteye_web/widgets/vehicleportal_widget.dart';

class OfficeHome extends StatefulWidget {
  final String? orgId;
  const OfficeHome({Key? key, this.orgId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OfficeHomeState createState() => _OfficeHomeState();
}

class _OfficeHomeState extends State<OfficeHome> {
  User? user = FirebaseAuth.instance.currentUser;

  String? currentscr = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 60.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(5)),
              color: white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  color: secondbg.withOpacity(0.20),
                ),
              ],
            ),
            child: const Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                  ),
                  child: Center(
                    child: Image(
                      image: AssetImage("assets/icons/appicon.png"),
                      height: 45,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 60,
                  width: 280,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: white,
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
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'Home';
                            }),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: cheryred),
                              child: const Text(
                                "Home",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: Text(
                              "Progam Management",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffD3D3D3),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'View';
                            }),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: cheryred),
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'customer';
                            }),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: cheryred),
                              child: const Text(
                                "Customer",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'customerreg';
                            }),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: cheryred),
                              child: const Text(
                                "Customer Registration",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'vehicleportal';
                            }),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: cheryred),
                              child: const Text(
                                "Vehicle Portal",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              currentscr = 'report';
                            }),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: cheryred),
                              child: const Text(
                                "Report",
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
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
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            blurRadius: 20,
                            color: secondbg.withOpacity(0.20),
                          ),
                        ],
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
          ),
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
