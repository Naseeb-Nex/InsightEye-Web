import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../widgets/home_widget.dart';

// ignore: must_be_immutable
class HomeTechCard extends StatefulWidget {
  String? uid;
  String? orgId;
  String? name;
  String? imgUrl;
  HomeTechCard({super.key, this.name, this.imgUrl, this.uid, this.orgId});

  @override
  State<HomeTechCard> createState() => _HomeTechCardState();
}

class _HomeTechCardState extends State<HomeTechCard> {
  FirebaseFirestore fb = FirebaseFirestore.instance;
  int a = 0;
  int c = 0;
  int p = 0;
  int pro = 0;

  @override
  void initState() {
    super.initState();
    if (mounted) startup();
  }

  startup() async {
    DateTime now = DateTime.now();
    String cday = DateFormat('MM d y').format(now);
    try {
      await fb
          .collection("organizations")
          .doc("${widget.orgId}")
          .collection('technician')
          .doc(widget.uid)
          .collection("Assignedpgm")
          .get()
          .then((snap) => {
                setState(() {
                  a = snap.size;
                })
              });

      await fb
          .collection("organizations")
          .doc("${widget.orgId}")
          .collection('technician')
          .doc(widget.uid)
          .collection("Completedpgm")
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
          .collection('technician')
          .doc(widget.uid)
          .collection("Pendingpgm")
          .get()
          .then((snap) => {
                setState(() {
                  p = snap.size;
                })
              });

      await fb
          .collection("organizations")
          .doc("${widget.orgId}")
          .collection('technician')
          .doc(widget.uid)
          .collection("Processingpgm")
          .get()
          .then((snap) => {
                setState(() {
                  pro = snap.size;
                })
              });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Relative Size
    Size s = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 20,
              color: bluebg.withOpacity(0.09),
            ),
          ],
        ),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 82,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 233, 196, 255),
                    image: DecorationImage(
                      image: widget.imgUrl != null
                          ? NetworkImage("${widget.imgUrl}")
                          : const AssetImage("assets/icons/avataricon.png")
                              as ImageProvider<Object>,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 17),
                    SizedBox(
                      width: s.width * 0.235,
                      child: Text(
                        "${widget.name}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '#technician',
                      style: TextStyle(
                        color: Color(0xFFA9A9A9),
                        fontSize: 10,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFD870),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          "$a",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF73F468),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          '$c',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF4658),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          '$p',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF48D4FC),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          '$pro',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Assigntechpgm(
                            uid: widget.uid,
                            name: widget.name,
                            techuid: widget.uid,
                            orgId: widget.orgId,
                            imgURl: widget.imgUrl,
                            a: a,
                            c: c,
                            p: p,
                            pro: pro,
                          ))),
                  child: Container(
                    width: 120,
                    height: 31,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFB954F3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 15,
                          offset: Offset(0, 3),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 8,
                              right: 8,
                            ),
                            child: Text(
                              'Schedule Task',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                              width: 25,
                              height: 23,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFCE7AFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Center(
                                  child: Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/icons/left-arrow.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ))),
                        ]),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
