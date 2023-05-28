import 'package:insighteye_web/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insighteye_web/widgets/export_widget.dart';
import 'package:insighteye_web/screens/officehomesrc.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:insighteye_web/componets/vscroll.dart';

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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              "Home",
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff8F9194),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                      flex: 3,
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: cheryred),
                                ),
                                const Text(
                                  " Pending Programs",
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff273746),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "$p",
                              style: const TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 3,
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                  " Completed Programs",
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff273746),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "$c",
                              style: const TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff273746),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black26,
                    ),
                    Text(
                      " Technicians",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    height: 2,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: size.height * 0.55,
            child: TechHorizontalList(
              orgId: widget.orgId,
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TechHorizontalList extends StatelessWidget {
  String? orgId;
  TechHorizontalList({Key? key, this.orgId}) : super(key: key);

  FirebaseFirestore fb = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fb
            .collection("organizations")
            .doc("$orgId")
            .collection('technician')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                        child: Text(
                          "Something Went Wrong :(",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 17,
                              color: cheryred),
                        ),
                      );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: cheryred,
              ),
            );
          }

          final List techprofile = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            techprofile.add(a);
            a['uid'] = document.id;
          }).toList();
          return ScrollConfiguration(
            behavior: Vscroll(),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: techprofile.length,
              itemBuilder: (context, i) {
                return Techcard(
                  uid: techprofile[i]['uid'],
                  name: techprofile[i]['name'],
                  imgUrl: techprofile[i]['imgUrl'],
                  orgId: orgId,
                );
              },
            ),
          );
        });
  }
}

// ignore: must_be_immutable
class Techcard extends StatefulWidget {
  String? uid;
  String? orgId;
  String? name;
  String? imgUrl;

  Techcard({Key? key, this.name, this.imgUrl, this.uid, this.orgId})
      : super(key: key);

  @override
  _TechcardState createState() => _TechcardState();
}

class _TechcardState extends State<Techcard> {
  int a = 0;
  int c = 0;
  FirebaseFirestore fb = FirebaseFirestore.instance;
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
    return Card(
      color: const Color(0xFFFBFCFC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 15,
      shadowColor: primarybg,
      child: SizedBox(
        width: 250,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  backgroundColor: white,
                  backgroundImage: widget.imgUrl != null
                      ? NetworkImage("${widget.imgUrl}")
                      : const AssetImage("assets/icons/avataricon.png")
                          as ImageProvider<Object>?,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${widget.name}",
                style: const TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff273746),
                ),
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
                        color: Colors.yellow),
                  ),
                  const Text(
                    " Assingned Programs    ",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff273746),
                    ),
                  ),
                  Text(
                    "$a",
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 13,
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
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff273746),
                    ),
                  ),
                  Text(
                    "$c",
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 13,
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
                        color: cheryred),
                  ),
                  const Text(
                    " Pending Programs        ",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff273746),
                    ),
                  ),
                  Text(
                    "$p",
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 13,
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
                        color: Colors.blue),
                  ),
                  const Text(
                    " Processing Programs   ",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff273746),
                    ),
                  ),
                  Text(
                    "$pro",
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 13,
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
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Assigntechpgm(
                          uid: widget.uid,
                          name: widget.name,
                          username: widget.uid,
                          orgId: widget.orgId,
                        ))),
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), color: cheryred),
                  alignment: Alignment.center,
                  child: const Text(
                    "Assign Program",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Assigntechpgm extends StatefulWidget {
  Assigntechpgm({Key? key, this.name, this.uid, this.username, this.orgId})
      : super(key: key);

  String? name;
  String? uid;
  String? username;
  String? orgId;

  @override
  // ignore: library_private_types_in_public_api
  _AssigntechpgmState createState() => _AssigntechpgmState();
}

class _AssigntechpgmState extends State<Assigntechpgm> {
  int a = 0;
  int c = 0;
  FirebaseFirestore fb = FirebaseFirestore.instance;
  int p = 0;
  int pro = 0;

  String _currentsrc = "Assign";

  @override
  void initState() {
    super.initState();
    if (mounted) {
      startup();
    }
  }

  startup() async {
    DateTime now = DateTime.now();
    String cday = DateFormat('MM d y').format(now);
    try {
      await fb
          .collection("organizations")
          .doc("${widget.orgId}")
          .collection('Technician')
          .doc(widget.username)
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
          .collection('Technician')
          .doc(widget.username)
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
          .collection('Technician')
          .doc(widget.username)
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
          .collection('Technician')
          .doc(widget.username)
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
                          builder: (context) => const OfficeHome(),
                        )),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue),
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
                            builder: (context) => const OfficeHome(),
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
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.asset("assets/icons/avataricon.png"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "${widget.name}",
                            style: const TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
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
                              "$a",
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
                              "$c",
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
                                  color: cheryred),
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
                              "$p",
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
                                  color: Colors.blue),
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
                              "$pro",
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
                                    : Colors.blue,
                                border: Border.all(color: Colors.blue)),
                            child: Text(
                              "Assign Programs",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _currentsrc == "Assign"
                                    ? Colors.blue
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
                              color:
                                  _currentsrc == "Status" ? white : Colors.blue,
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Text(
                              "Status",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _currentsrc == "Status"
                                    ? Colors.blue
                                    : white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // InkWell(
                        //   onTap: () => setState(() {
                        //     _currentsrc = 'Schedule';
                        //   }),
                        //   child: Container(
                        //     height: 55,
                        //     width: double.infinity,
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(30),
                        //       color: _currentsrc == "Schedule"
                        //           ? white
                        //           : Colors.blue,
                        //       border: Border.all(color: Colors.blue),
                        //     ),
                        //     child: Text(
                        //       "Schedule",
                        //       style: TextStyle(
                        //         fontFamily: "Nunito",
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.bold,
                        //         color: _currentsrc == "Schedule"
                        //             ? Colors.blue
                        //             : white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
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
                      username: widget.username,
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
  String? username;
  String? orgId;

  Techsrcwrapper(
      {Key? key, this.src, this.uid, this.username, this.name, this.orgId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (src == 'Status') {
      return Statussrc(uid: uid, username: username, techname: name, orgId: orgId);
    // } else if (src == 'Schedule') {
    //   return SchedulePgmSrc(uid: uid, username: username, techname: name);
    }
    return Assignpgmwidget(uid: uid, username: username, techname: name, orgId: orgId);
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