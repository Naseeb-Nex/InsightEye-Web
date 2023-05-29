import 'package:flutter/material.dart';
import 'package:insighteye_web/componets/processing_tech_card.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';

// ignore: must_be_immutable
class Techprocessing extends StatefulWidget {
  String? uid;
  String? techuid;
  String? techname;
  String? orgId;

  Techprocessing({Key? key, this.uid, this.techuid, this.techname, this.orgId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TechprocessingState createState() => _TechprocessingState();
}

class _TechprocessingState extends State<Techprocessing> {
  final List _allpgm = [];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: htechassignswipe(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
            .collection("organizations")
          .doc("${widget.orgId}")
                .collection('technician')
                .doc(widget.techuid)
                .collection("Processingpgm")
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
                              color: cheryred),
                        ),
                      );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: double.infinity,
                  color: white,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: cheryred,
                    ),
                  ),
                );
              }
              _allpgm.clear();
              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                _allpgm.add(a);
                a['uid'] = document.id;
              }).toList();

              return Column(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  for (var i = 0; i < _allpgm.length; i++) ...[
                    Protechcard(
                      uid: widget.uid,
                      techuid: widget.techuid,
                      orgId: widget.orgId,
                      name: _allpgm[i]["name"],
                      address: _allpgm[i]["address"],
                      loc: _allpgm[i]["loc"],
                      chrg: _allpgm[i]["chrg"],
                      pgm: _allpgm[i]["pgm"],
                      phn: _allpgm[i]["phn"],
                      type: _allpgm[i]["type"],
                      upDate: _allpgm[i]["upDate"],
                      upTime: _allpgm[i]["upTime"],
                      docname: _allpgm[i]["docname"],
                      remarks: _allpgm[i]["remarks"],
                      ptime: _allpgm[i]["ptime"],
                      pdate: _allpgm[i]["pdate"],
                      pdocname: _allpgm[i]["pdocname"],
                      custdocname: _allpgm[i]["custdocname"],
                      prospec: _allpgm[i]["prospec"],
                      instadate: _allpgm[i]["instadate"],
                    )
                  ]
                ],
              );
            }),
      ),
    );
  }
}

// ignore: camel_case_types
class htechassignswipe extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
