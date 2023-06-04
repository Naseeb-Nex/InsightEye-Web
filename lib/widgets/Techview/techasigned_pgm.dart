import 'package:flutter/material.dart';
import 'package:insighteye_web/componets/invoice_service.dart';
import 'package:insighteye_web/componets/view_pgm_card.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';

import '../../componets/simplealertbox.dart';

// ignore: must_be_immutable
class Techasign extends StatefulWidget {
  String? uid;
  String? techuid;
  String? techname;
  String? orgId;

  Techasign({Key? key, this.uid, this.techuid, this.techname, this.orgId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TechasignState createState() => _TechasignState();
}

class _TechasignState extends State<Techasign> {
  final List _allpgm = [];
  bool downloading = false;
  FirebaseFirestore fb = FirebaseFirestore.instance;

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
                .collection("Assignedpgm")
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
              _allpgm.sort((a, b) => a["priority"].compareTo(b["priority"]));

              return Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      for (var i = 0; i < _allpgm.length; i++) ...[
                        Viewpgmcard(
                          name: _allpgm[i]["name"],
                          address: _allpgm[i]["address"],
                          loc: _allpgm[i]["loc"],
                          pgm: _allpgm[i]["pgm"],
                          phn: _allpgm[i]["phn"],
                          type: _allpgm[i]["type"],
                          upDate: _allpgm[i]["upDate"],
                          upTime: _allpgm[i]["upTime"],
                          docname: _allpgm[i]["docname"],
                          prospec: _allpgm[i]["prospec"],
                          instadate: _allpgm[i]["instadate"],
                        )
                      ]
                    ],
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future:
                        fb.collection("organizations").doc(widget.orgId).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: bluebg,
                              ),
                              child: const Center(
                                  child: Icon(Icons.warning_amber_rounded,
                                      color: white)),
                            )
                          ],
                        );
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: bluebg,
                              ),
                              child: const Center(
                                  child: Icon(Icons.warning_amber_rounded,
                                      color: white)),
                            )
                          ],
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
                      return  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                // TODO : Change the Orignization Details
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Datepicker(
                                        programs: _allpgm,
                                        techname: widget.techname,
                                        orgName: data['orgname'],
                                        orgType: data['orgtype'],
                                        orgAdress: data['address'],
                                      );
                                    });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: bluebg,
                                ),
                                child: Stack(
                                  children: [
                                    const Center(
                                        child:
                                            Icon(Icons.download, color: white)),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: downloading
                                              ? const CircularProgressIndicator(
                                                  color: Color(0XFF219ebc),
                                                )
                                              : null,
                                        ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: bluebg,
                            ),
                            child: const Center(
                                child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: white,
                                      strokeWidth: 5,
                                    ))),
                          )
                        ],
                      );
                    },
                  ),
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

// ignore: must_be_immutable
class Datepicker extends StatelessWidget {
  List programs;
  String? techname;
  String? orgName;
  String? orgType;
  String? orgAdress;

  final PdfInvoiceService invoice = PdfInvoiceService();

  Datepicker({
    Key? key,
    required this.programs,
    required this.techname,
    required this.orgName,
    required this.orgType,
    required this.orgAdress,
  }) : super(key: key);

  final TextEditingController dateConroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: s.height * 0.4,
        width: s.width * 0.35,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Date Picker",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "Please enter the Date to the Program",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Date : ",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
                  SizedBox(
                    width: s.width * 0.20,
                    child: TextFormField(
                      autofocus: false,
                      controller: dateConroller,
                      maxLines: 1,
                      keyboardType: TextInputType.datetime,
                      onSaved: (value) {
                        dateConroller.text = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Date Feild Cannot be empty");
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 60,
                    width: 130,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 5,
                              color: black.withOpacity(0.2),
                              offset: const Offset(5, 10))
                        ],
                        color: cheryred,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () => pdfconverter(context),
                  child: Container(
                    height: 60,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 5,
                              color: black.withOpacity(0.2),
                              offset: const Offset(5, 10))
                        ],
                        color: limegreen),
                    child: const Center(
                      child: Text(
                        "Okay",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void pdfconverter(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SimpleCustomAlert(
                "Downloading in Progress Please Wait!",
                Color(0XFFbbd0ff),
                "Progressing");
          });
      final data = await invoice.createInvoice(programs, "$techname",
          dateConroller.text, "$orgName", "$orgType", "$orgAdress");
      invoice.savePdfFile("$techname ${dateConroller.text}", data);
    }
  }
}
