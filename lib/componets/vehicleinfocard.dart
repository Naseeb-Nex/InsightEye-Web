import 'package:flutter/material.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
// package
import 'package:cloud_firestore/cloud_firestore.dart';
// components
import 'package:insighteye_web/componets/loadingDialog.dart';

// ignore: must_be_immutable
class VechicleInfoCard extends StatefulWidget {
  String? name;
  String? desc;
  String? type;
  String? status;
  String? statusdesc;
  String? techname;
  String? techuid;
  String? vdocname;
  String? update;
  String? uptime;
  String? orgId;

  VechicleInfoCard({
    Key? key,
    this.name,
    this.desc,
    this.type,
    this.status,
    this.statusdesc,
    this.techname,
    this.techuid,
    this.vdocname,
    this.update,
    this.uptime,
    this.orgId,
  }) : super(key: key);

  @override
  State<VechicleInfoCard> createState() => _VechicleInfoCardState();
}

class _VechicleInfoCardState extends State<VechicleInfoCard> {
  bool _isviz = false;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 2),
            spreadRadius: 1.5,
            blurRadius: 4,
            color: secondbg.withOpacity(0.13),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(s.width * 0.008),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: s.width * 0.05,
                      height: s.width * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15), color: vybg),
                      clipBehavior: Clip.hardEdge,
                      child: Vehicleimagewrapper(widget.type),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: s.width * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "${widget.name}",
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                VStatuswrapper(status: widget.status),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "${widget.desc}",
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: _isviz,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: EdgeInsets.all(s.width * 0.008),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 3,
                            color: black.withOpacity(.05),
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "More Option",
                              style: TextStyle(
                                color: Color(0xff828a96),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: s.width * 0.05,
                            height: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff828a96),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0XFFf2f4f8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline_rounded,
                                      color: Color(0XFF224c84),
                                      size: 25,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${widget.techname}",
                                      style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Color(0XFF224c84),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => recall(context, widget.vdocname),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        color: black.withOpacity(.05),
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    "Recall",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                      color: hpColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: widget.status == "Ongoing"
                  ? Container(
                      height: 80,
                      alignment: Alignment.bottomRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: InkWell(
                                onTap: () => setState(() {
                                  _isviz = !_isviz;
                                }),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: s.width * 0.01),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          color: black.withOpacity(.05),
                                          offset: const Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    child: _isviz
                                        ? const Icon(Icons.close,
                                            color: hpColor)
                                        : const Icon(Iconsax.arrow_down_1,
                                            color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> recall(BuildContext context, String? docname) async {
    FirebaseFirestore fb = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    String techvdoc = DateFormat('MM d').format(now);

    showDialog(context: context, builder: ((context) => const LoadingDialog()));
    await fb
        .collection("organizations")
        .doc("${widget.orgId}")
        .collection("technician")
        .doc(widget.techuid)
        .collection("Vehicle")
        .doc(techvdoc)
        .delete();

    // status change
    await fb
        .collection("organizations")
        .doc("${widget.orgId}")
        .collection("Garage")
        .doc(docname)
        .set({"status": "Available", "techname": "none", "techuid": "none"},
            SetOptions(merge: true));

    // Navigator.of(context).pop();
    Navigator.pop(context);
    setState(() {
      _isviz = false;
    });
  }
}

// ignore: must_be_immutable
class Vehicleimagewrapper extends StatelessWidget {
  String? type;
  Vehicleimagewrapper(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == "Scooter") {
      return Image.asset(
        "assets/icons/scooter.jpg",
        fit: BoxFit.cover,
      );
    } else if (type == "Truck") {
      return Image.asset(
        "assets/icons/truck.png",
        fit: BoxFit.cover,
      );
    } else if (type == "Self Vehicle") {
      return Image.asset(
        "assets/icons/self_vehicle.jpg",
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      "assets/icons/bike.jpg",
      fit: BoxFit.cover,
    );
  }
}

// ignore: must_be_immutable
class VStatuswrapper extends StatelessWidget {
  String? status;
  VStatuswrapper({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == "Ongoing") {
      return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: yellowbg,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: black.withOpacity(.05),
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Text(
          "$status",
          style: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: yellowfg,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greenbg,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 1,
            color: black.withOpacity(.05),
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Text(
        "$status",
        style: const TextStyle(
          fontFamily: "Montserrat",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.green,
        ),
      ),
    );
  }
}
