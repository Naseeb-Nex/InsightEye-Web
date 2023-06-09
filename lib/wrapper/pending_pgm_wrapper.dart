import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:insighteye_web/componets/view_pgm_card.dart';
import 'package:insighteye_web/constants/constants.dart';

class PendingPgmWrapper extends StatelessWidget {
  String? orgId;
  PendingPgmWrapper({Key? key, this.orgId}) : super(key: key);
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
            print('Something went Wrong');
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

          List _allpgm = [];
          _allpgm.clear();
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            _allpgm.add(a);
            a['uid'] = document.id;
          }).toList();
          List pendingpgm =
              _allpgm.where((i) => i['status'] == 'pending').toList();
          return Column(
            children: [
              const SizedBox(
                width: 30,
              ),
              for (var i = 0; i < pendingpgm.length; i++) ...[
                Viewpgmcard(
                  name: pendingpgm[i]["name"],
                  address: pendingpgm[i]["address"],
                  loc: pendingpgm[i]["loc"],
                  pgm: pendingpgm[i]["pgm"],
                  phn: pendingpgm[i]["phn"],
                  type: pendingpgm[i]["type"],
                  upDate: pendingpgm[i]["upDate"],
                  upTime: pendingpgm[i]["upTime"],
                  docname: pendingpgm[i]["docname"],
                )
              ]
            ],
          );
        });
  }
}
