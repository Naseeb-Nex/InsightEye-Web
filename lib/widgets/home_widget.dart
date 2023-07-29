import 'dart:ui';
import 'package:insighteye_web/componets/3circularprogress.dart';
import 'package:insighteye_web/componets/animatedcircularprogress.dart';
import 'package:insighteye_web/componets/hometechcard.dart';
import 'package:insighteye_web/componets/lineChart.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insighteye_web/widgets/export_widget.dart';
import 'package:insighteye_web/screens/officehomesrc.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

// ignore: must_be_immutable
class Homewidget extends StatefulWidget {
  String? orgId;
  Homewidget({Key? key, this.uid, this.orgId}) : super(key: key);

  String? uid;

  @override
  // ignore: library_private_types_in_public_api
  _HomewidgetState createState() => _HomewidgetState();
}

class _HomewidgetState extends State<Homewidget> {
  FirebaseFirestore fb = FirebaseFirestore.instance;
  int p = 0, c = 0;
  final List techprofile = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      pgmsetup();
    }
  }

  pgmsetup() async {
    DateTime now = DateTime.now();
    String cday = DateFormat('MM d y').format(now);
    try {
      await fb
          .collection("organizations")
          .doc("${widget.orgId}")
          .collection('Completedpgm')
          .doc("Day")
          .collection(cday)
          .get()
          .then((snap) => {
                setState(() {
                  c = snap.size;
                })
              });
      await fb
          .collection("organizations")
          .doc("${widget.orgId}")
          .collection('Programs')
          .get()
          .then((snap) => {
                setState(() {
                  p = snap.size;
                })
              });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive Size
    Size s = MediaQuery.of(context).size;

    DateTime now = DateTime.now();
    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);

    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: s.width * 0.0093),
          child: Row(
            children: [
              // Left Side
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 241,
                        height: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: const Color(0XFF9643D6),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(children: [
                          Positioned(
                            top: -80.0,
                            left: -80.0,
                            child: Container(
                              width: 160.0,
                              height: 160.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0XFFB758FF).withOpacity(0.3),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: const SizedBox(
                                  width: 160,
                                  height: 160,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 35.17),
                                child: Container(
                                    width: 52.25,
                                    height: 51.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: white.withOpacity(0.05),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/icons/homegraph.png",
                                        color: white,
                                        width: 24.12,
                                        height: 23.81,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 21.53,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "$p",
                                        style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600,
                                            color: white),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Pending",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0XFFF6F6FB)
                                                .withOpacity(0.7)),
                                      ),
                                    ]),
                              )
                            ],
                          )
                        ]),
                      ),
                      SizedBox(
                        width: s.width * 0.0186,
                      ),
                      Container(
                        width: 241,
                        height: 190,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 60,
                                color: const Color.fromARGB(255, 201, 224, 255)
                                    .withOpacity(0.5),
                                offset: const Offset(0, 10),
                              )
                            ]),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(children: [
                          Positioned(
                            top: -80.0,
                            left: -80.0,
                            child: Container(
                              width: 160.0,
                              height: 160.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0XFFEAEAEA).withOpacity(0.1),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: const SizedBox(
                                  width: 160,
                                  height: 160,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 35.17),
                                child: Container(
                                    width: 52.25,
                                    height: 51.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0XFFC5BDBD)
                                          .withOpacity(0.1),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/icons/homedate.png",
                                        width: 24.12,
                                        height: 23.81,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 21.53,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "$c",
                                        style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF2B2F42)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Completed",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0XFF2B2F42)
                                                .withOpacity(0.7)),
                                      ),
                                    ]),
                              )
                            ],
                          )
                        ]),
                      ),
                    ],
                  ),
                  // Circular Progress Bar
                  SizedBox(
                    height: s.width * 0.0093,
                  ),
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: fb
                        .collection("organizations")
                        .doc("${widget.orgId}")
                        .collection("Reports")
                        .doc(year)
                        .collection("Month")
                        .doc(month)
                        .collection(day)
                        .doc("Counter")
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          width: 482 + s.width * 0.0186,
                          height: s.height * 0.3145,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 60,
                                color: const Color.fromARGB(255, 201, 224, 255)
                                    .withOpacity(0.5),
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: (482 + s.width * 0.0186) / 2,
                                    height: s.height * 0.22,
                                    child: AnimatedProgressBar()),
                                SizedBox(width: s.width * 0.0186),
                                SizedBox(
                                  height: 200,
                                  width: ((482 + s.width * 0.0186) / 2) -
                                      s.width * 0.0186,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        """Today's
Performance 
Metrics""",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: s.height * 0.01,
                                      ),
                                      Container(
                                        width: 160,
                                        height: 28,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: const Color(0xFF39DF2B),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Color(0xFFEDEDFC),
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Completed',
                                              style: TextStyle(
                                                color: Color(0xFFEDEDFC),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 28,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: const Color(0xFF01BAEF),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Color(0xFFEDEDFC),
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Processing',
                                              style: TextStyle(
                                                color: Color(0xFFEDEDFC),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 28,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: const Color(0xFFE5383B),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Color(0xFFEDEDFC),
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Pending',
                                              style: TextStyle(
                                                color: Color(0xFFEDEDFC),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.start,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        );
                      }

                      if (snapshot.hasData) {
                        var output = snapshot.data!.data();
                        double a = 0,
                            c = 0,
                            pro = 0,
                            p = 0,
                            completed = 0,
                            pending = 0,
                            processing = 0,
                            progress = 0,
                            total = 0;

                        if (output != null) {
                          var assigned = output['assigned'];
                          var competed = output['completed'];
                          var pending = output['pending'];
                          var processing = output['processing'];

                          if (assigned != null) {
                            a = assigned.toDouble();
                          } else {
                            a = 0;
                          }

                          if (pending != null) {
                            p = pending.toDouble();
                          } else {
                            p = 0;
                          }

                          if (processing != null) {
                            pro = processing.toDouble();
                          } else {
                            pro = 0;
                          }

                          if (competed != null) {
                            c = competed.toDouble();
                          } else {
                            c = 0;
                          }
                        }

                        if (a < (c + p + pro) && a != 0) {
                          total = c + p + pro;
                          completed = (c / total) * 100;
                          pending = (p / total) * 100;
                          processing = (pro / total) * 100;
                          progress = completed + pending + processing;
                        } else if (a != 0) {
                          completed = (c / a) * 100;
                          pending = (p / a) * 100;
                          processing = (pro / a) * 100;
                          progress = completed + pending + processing;
                          total = a;
                        } else {
                          completed = 0;
                          pending = 0;
                          processing = 0;
                          progress = 0;
                          total = 1;
                        }

                        // return Text("total: $total, progress: $progress, completed: $completed, pending: $pending, processing: $processing");

                        return Container(
                          width: 482 + s.width * 0.0186,
                          height: s.height * 0.3145,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 60,
                                color: const Color.fromARGB(255, 201, 224, 255)
                                    .withOpacity(0.5),
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: (482 + s.width * 0.0186) / 2,
                                    height: s.height * 0.22,
                                    child: ThreeCircularProgressBar(
                                      strokeWidth: 21,
                                      total: total.round(),
                                      progress: progress.round(),
                                      completed: completed.round(),
                                      processing: processing.round(),
                                      pending: pending.round(),
                                    )),
                                SizedBox(width: s.width * 0.0186),
                                SizedBox(
                                  height: 200,
                                  width: ((482 + s.width * 0.0186) / 2) -
                                      s.width * 0.0186,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        """Today's
Performance 
Metrics""",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: s.height * 0.01,
                                      ),
                                      Container(
                                        width: 160,
                                        height: 28,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: const Color(0xFF39DF2B),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '$c',
                                                style: const TextStyle(
                                                  color: Color(0xFFEDEDFC),
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Completed',
                                              style: TextStyle(
                                                color: Color(0xFFEDEDFC),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 28,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: const Color(0xFF01BAEF),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '$pro',
                                                style: const TextStyle(
                                                  color: Color(0xFFEDEDFC),
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Processing',
                                              style: TextStyle(
                                                color: Color(0xFFEDEDFC),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 28,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: const Color(0xFFE5383B),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '$p',
                                                style: const TextStyle(
                                                  color: Color(0xFFEDEDFC),
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Pending',
                                              style: TextStyle(
                                                color: Color(0xFFEDEDFC),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.start,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        );
                      }

                      return Container(
                        width: 482 + s.width * 0.0186,
                        height: s.height * 0.3145,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 60,
                              color: const Color.fromARGB(255, 201, 224, 255)
                                  .withOpacity(0.5),
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: (482 + s.width * 0.0186) / 2,
                                  height: s.height * 0.22,
                                  child: AnimatedProgressBar()),
                              SizedBox(width: s.width * 0.0186),
                              SizedBox(
                                height: 200,
                                width: ((482 + s.width * 0.0186) / 2) -
                                    s.width * 0.0186,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      """Today's
Performance 
Metrics""",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: s.height * 0.01,
                                    ),
                                    Container(
                                      width: 160,
                                      height: 28,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: const Color(0xFF39DF2B),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 40,
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              '0',
                                              style: TextStyle(
                                                color: Color(0xFFEDEDFC),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'Completed',
                                            style: TextStyle(
                                              color: Color(0xFFEDEDFC),
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 160,
                                      height: 28,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: const Color(0xFF01BAEF),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 40,
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              '0',
                                              style: TextStyle(
                                                color: Color(0xFFEDEDFC),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'Processing',
                                            style: TextStyle(
                                              color: Color(0xFFEDEDFC),
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 160,
                                      height: 28,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: const Color(0xFFE5383B),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 40,
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              '0',
                                              style: TextStyle(
                                                color: Color(0xFFEDEDFC),
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'Pending',
                                            style: TextStyle(
                                              color: Color(0xFFEDEDFC),
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.start,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      );
                    },
                  ),
                  // Weekly Data
                  SizedBox(
                    height: s.width * 0.0093,
                  ),
                  Container(
                    width: 482 + s.width * 0.0186,
                    height: s.height * 0.3445,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 60,
                          color: const Color.fromARGB(255, 201, 224, 255)
                              .withOpacity(0.5),
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: const Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 20),
                          child: Text(
                            'Statistics',
                            style: TextStyle(
                              color: Color(0xFF2F2F31),
                              fontSize: 22,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Center(child: LineChartwidget()),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: s.width * 0.0186,
              ),
              // Techlist
              Container(
                // width: s.width * 0.5116,
                width: s.width * 0.42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 60,
                      color: const Color.fromARGB(255, 201, 224, 255)
                          .withOpacity(0.5),
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 20, bottom: 25),
                      child: Text(
                        'Technicians',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: fb
                              .collection("organizations")
                              .doc("${widget.orgId}")
                              .collection('technician')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  "Something Went Wrong :(",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      color: vioetbg),
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                width: s.width * 0.395,
                                height: s.height * 0.85,
                                child: const Center(
                                  child: SizedBox(
                                    width: 50,
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.ballBeat,
                                      colors: [hpColor],
                                      strokeWidth: 10,
                                    ),
                                  ),
                                ),
                              );
                            }

                            final List techprofile = [];
                            snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map a = document.data() as Map<String, dynamic>;
                              techprofile.add(a);
                              a['uid'] = document.id;
                            }).toList();

                            return SizedBox(
                              width: s.width * 0.395,
                              height: s.height * 0.85,
                              child: ListView.builder(
                                itemCount: techprofile.length,
                                itemBuilder: (context, i) {
                                  return HomeTechCard(
                                    uid: techprofile[i]['uid'],
                                    name: techprofile[i]['name'],
                                    imgUrl: techprofile[i]['imgUrl'],
                                    orgId: widget.orgId,
                                  );
                                },
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: s.width * 0.01,
              ),
              Container(
                  width: s.width * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 60,
                        color: const Color.fromARGB(255, 201, 224, 255)
                            .withOpacity(0.5),
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 25),
                        child: Text(
                          'SuperVisor',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: fb
                              .collection("organizations")
                              .doc("${widget.orgId}")
                              .collection('supervisor')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  "Something Went Wrong :(",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 17,
                                      color: vioetbg),
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                width: s.width * 0.395,
                                height: s.height * 0.85,
                                child: const Center(
                                  child: SizedBox(
                                    width: 50,
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.ballBeat,
                                      colors: [hpColor],
                                      strokeWidth: 10,
                                    ),
                                  ),
                                ),
                              );
                            }

                            final List supervisorProfile = [];
                            snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map a = document.data() as Map<String, dynamic>;
                              supervisorProfile.add(a);
                              a['uid'] = document.id;
                            }).toList();

                            return SizedBox(
                              width: s.width * 0.395,
                              height: s.height * 0.85,
                              child: ListView.builder(
                                itemCount: supervisorProfile.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: s.width * 0.07,
                                          height: s.width * 0.07,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color.fromARGB(
                                                255, 233, 196, 255),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/supervisor-img.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 9.0),
                                          child: Text(
                                            '${supervisorProfile[i]['name']}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                    ],
                  ))
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class Assigntechpgm extends StatefulWidget {
  String? name;
  String? uid;
  String? techuid;
  String? orgId;
  String? imgURl;
  int a;
  int c;
  int p;
  int pro;

  Assigntechpgm(
      {Key? key,
      this.name,
      this.uid,
      this.techuid,
      this.orgId,
      this.imgURl,
      required this.a,
      required this.c,
      required this.p,
      required this.pro})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AssigntechpgmState createState() => _AssigntechpgmState();
}

class _AssigntechpgmState extends State<Assigntechpgm> {
  FirebaseFirestore fb = FirebaseFirestore.instance;

  String _currentsrc = "Assign";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 60,
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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfficeHome(),
                        )),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0XFF793BA8)),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OfficeHome(),
                          )),
                      child: const Image(
                        image: AssetImage("assets/icons/appicon.png"),
                        height: 45,
                        filterQuality: FilterQuality.high,
                      ),
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
                height: double.infinity,
                width: 350,
                padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        SizedBox(
                          height: 160,
                          width: 160,
                          child: CircleAvatar(
                            backgroundColor: white,
                            backgroundImage: widget.imgURl != null
                                ? NetworkImage("${widget.imgURl}")
                                : const AssetImage(
                                        "assets/icons/tech_avatar1.png")
                                    as ImageProvider<Object>?,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "${widget.name}",
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff273746),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.yellow),
                            ),
                            const Text(
                              " Assingned Programs    ",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                            Text(
                              "${widget.a}",
                              style: const TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.greenAccent),
                            ),
                            const Text(
                              " Completed Programs   ",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                            Text(
                              "${widget.c}",
                              style: const TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: cherryred),
                            ),
                            const Text(
                              " Pending Programs        ",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                            Text(
                              "${widget.a}",
                              style: const TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                            ),
                            const Text(
                              " Processing Programs   ",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                            Text(
                              "${widget.pro}",
                              style: const TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            _currentsrc = 'Assign';
                          }),
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: _currentsrc == "Assign"
                                    ? white
                                    : const Color(0XFF793BA8),
                                border:
                                    Border.all(color: const Color(0XFF793BA8))),
                            child: Text(
                              "Assign Programs",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _currentsrc == "Assign"
                                    ? const Color(0XFF793BA8)
                                    : white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            _currentsrc = 'Status';
                          }),
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: _currentsrc == "Status"
                                  ? white
                                  : const Color(0XFF793BA8),
                              border:
                                  Border.all(color: const Color(0XFF793BA8)),
                            ),
                            child: Text(
                              "Status",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _currentsrc == "Status"
                                    ? const Color(0XFF793BA8)
                                    : white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 10, top: 10, bottom: 5),
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
                    clipBehavior: Clip.hardEdge,
                    // Use wrapper here
                    child: Techsrcwrapper(
                      src: _currentsrc,
                      uid: widget.uid,
                      techuid: widget.uid,
                      name: widget.name,
                      orgId: widget.orgId,
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Techsrcwrapper extends StatelessWidget {
  String? name;
  String? src;
  String? uid;
  String? techuid;
  String? orgId;

  Techsrcwrapper(
      {Key? key, this.src, this.uid, this.techuid, this.name, this.orgId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (src == 'Status') {
      return Statussrc(
          uid: uid, techuid: techuid, techname: name, orgId: orgId);
      // } else if (src == 'Schedule') {
      //   return SchedulePgmSrc(uid: uid, techuid: techuid, techname: name);
    }
    return Assignpgmwidget(
        uid: uid, techuid: techuid, techname: name, orgId: orgId);
  }
}

class Hscroll extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
