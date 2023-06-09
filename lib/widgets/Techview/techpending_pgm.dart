import 'package:flutter/material.dart';
import 'package:insighteye_web/componets/pending_tech_card.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';

// ignore: must_be_immutable
class Techpending extends StatefulWidget {
  String? uid;
  String? techuid;
  String? techname;
  String? orgId;

  Techpending({Key? key, this.uid, this.techuid, this.techname, this.orgId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TechpendingState createState() => _TechpendingState();
}

class _TechpendingState extends State<Techpending> {
  final List _allpendingpgm = [];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: Htechassignswipe(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("organizations")
                .doc("${widget.orgId}")
                .collection('technician')
                .doc(widget.techuid)
                .collection("Pendingpgm")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: double.infinity,
                  color: white,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: vioetbg,
                    ),
                  ),
                );
              }
              _allpendingpgm.clear();
              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                _allpendingpgm.add(a);
                a['uid'] = document.id;
              }).toList();

              return Column(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  for (var i = 0; i < _allpendingpgm.length; i++) ...[
                    PendingTechcard(
                      orgId: widget.orgId,
                      uid: widget.uid,
                      techuid: _allpendingpgm[i]["techuid"],
                      name: _allpendingpgm[i]["name"],
                      address: _allpendingpgm[i]["address"],
                      loc: _allpendingpgm[i]["loc"],
                      chrg: _allpendingpgm[i]["chrg"],
                      pgm: _allpendingpgm[i]["pgm"],
                      phn: _allpendingpgm[i]["phn"],
                      type: _allpendingpgm[i]["type"],
                      upDate: _allpendingpgm[i]["upDate"],
                      upTime: _allpendingpgm[i]["upTime"],
                      docname: _allpendingpgm[i]["docname"],
                      remarks: _allpendingpgm[i]["remarks"],
                      ptime: _allpendingpgm[i]["ptime"],
                      pdate: _allpendingpgm[i]["pdate"],
                      pdocname: _allpendingpgm[i]["pdocname"],
                      instadate: _allpendingpgm[i]["instadate"],
                      prospec: _allpendingpgm[i]["prospec"],
                      techname: _allpendingpgm[i]["techname"],
                      custdocname: _allpendingpgm[i]["custdocname"],
                    )
                  ]
                ],
              );
            }),
      ),
    );
  }
}

class Htechassignswipe extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
