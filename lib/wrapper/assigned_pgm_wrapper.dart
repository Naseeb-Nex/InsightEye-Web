import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:insighteye_web/componets/view_pgm_card.dart';
import 'package:insighteye_web/constants/constants.dart';

// ignore: must_be_immutable
class Assignedpgmwrapper extends StatelessWidget {
  String? orgId;
  Assignedpgmwrapper({Key? key, this.orgId}) : super(key: key);
  FirebaseFirestore fb = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fb
            .collection("organizations")
            .doc("$orgId")
            .collection('Programs')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something Went Wrong :(",
                style: TextStyle(
                    fontFamily: "Montserrat", fontSize: 17, color: hpColor),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              color: white,
              child: const Center(
                child: CircularProgressIndicator(
                  color: hpColor,
                ),
              ),
            );
          }

          final List allpgm = [];
          allpgm.clear();
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            allpgm.add(a);
            a['uid'] = document.id;
          }).toList();
          List assignedpgm =
              allpgm.where((i) => i['status'] == 'assigned').toList();
          return Column(
            children: [
              const SizedBox(
                width: 30,
              ),
              for (var i = 0; i < assignedpgm.length; i++) ...[
                Viewpgmcard(
                  name: assignedpgm[i]["name"],
                  address: assignedpgm[i]["address"],
                  loc: assignedpgm[i]["loc"],
                  pgm: assignedpgm[i]["pgm"],
                  phn: assignedpgm[i]["phn"],
                  type: assignedpgm[i]["type"],
                  upDate: assignedpgm[i]["upDate"],
                  upTime: assignedpgm[i]["upTime"],
                  prospec: assignedpgm[i]["prospec"],
                  instadate: assignedpgm[i]["instadate"],
                  docname: assignedpgm[i]["docname"],
                )
              ]
            ],
          );
        });
  }
}
