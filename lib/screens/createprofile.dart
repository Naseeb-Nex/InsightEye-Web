import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:insighteye_web/screens/officehomesrc.dart';

import '../componets/simplealertbox.dart';

class CreateProfileSrc extends StatefulWidget {
  final String? orgId;
  const CreateProfileSrc({super.key, this.orgId});

  @override
  State<CreateProfileSrc> createState() => _CreateProfileSrcState();
}

class _CreateProfileSrcState extends State<CreateProfileSrc> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //image upload
  late String imageUrl = "https://i.ibb.co/PDGbkwX/avatarnew-1.png";

  // form
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController phnController = TextEditingController();

  // loading
  bool load = false;

  @override
  Widget build(BuildContext context) {
    // Responsive Size
    Size s = MediaQuery.of(context).size;

    return Container(
      width: s.width,
      height: s.height,
      decoration: const BoxDecoration(
          gradient: RadialGradient(radius: 0.7, colors: [
        Color(0XFF5F87D3),
        Color(0XFF7A43AB),
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF623689),
                      offset: Offset(23, 23),
                      blurRadius: 59,
                    ),
                    BoxShadow(
                      color: Color(0xFF9250CD),
                      offset: Offset(-23, -23),
                      blurRadius: 59,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: s.height * 0.06542),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'CREATE PROFILE',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                    SizedBox(
                      height: s.height * 0.0214,
                    ),
                    Image.network(
                      imageUrl,
                      width: s.width * 0.12,
                      height: s.height * 0.17,
                    ),
                    SizedBox(
                      height: s.height * 0.0449,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: s.width * 0.2263,
                              child: TextFormField(
                                autofocus: false,
                                controller: nameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("This Field is empty");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  nameController.text = value!;
                                },
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelStyle: const TextStyle(
                                    fontFamily: "Montserrat",
                                    color: black,
                                  ),
                                  errorStyle: const TextStyle(
                                      fontFamily: "Montserrat", color: redbg),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF57308D))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Color(0XFFA3D8FF))),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Color(0XFFff0a54),
                                          width: 2.0)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2.0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: s.height * 0.0458,
                            ),
                            SizedBox(
                              width: s.width * 0.2263,
                              child: TextFormField(
                                autofocus: false,
                                controller: phnController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("This Field is empty");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  phnController.text = value!;
                                },
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  prefixText: '+91 ',
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelStyle: const TextStyle(
                                    fontFamily: "Montserrat",
                                    color: black,
                                  ),
                                  prefixStyle: const TextStyle(
                                    fontFamily: "Montserrat",
                                    color: black,
                                  ),
                                  errorStyle:
                                      const TextStyle(fontFamily: "Montserrat"),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF57308D))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Color(0XFFA3D8FF))),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Color(0XFFff0a54),
                                          width: 2.0)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2.0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: s.height * 0.0458,
                            ),
                            SizedBox(
                              width: s.width * 0.2263,
                              child: TextFormField(
                                autofocus: false,
                                controller: designationController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("This Field is empty");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  designationController.text = value!;
                                },
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Job Title",
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelStyle: const TextStyle(
                                    fontFamily: "Montserrat",
                                    color: black,
                                  ),
                                  errorStyle:
                                      const TextStyle(fontFamily: "Montserrat"),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF57308D))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Color(0XFFA3D8FF))),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Color(0XFFff0a54),
                                          width: 2.0)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2.0)),
                                ),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: s.height * 0.0488,
                    ),
                    SizedBox(
                      width: s.width * 0.2263,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade300,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 1.0],
                            colors: [
                              Color(0XFF7A43AB),
                              Color(0XFF7F54BA),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 5.0)
                          ],
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            minimumSize:
                                MaterialStateProperty.all(const Size(50, 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Save'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: "Montserrat"),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                    child: load
                                        ? const SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              color: white,
                                            ),
                                          )
                                        : null),
                              ],
                            ),
                          ),
                          onPressed: () {
                            uploadData();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  void uploadData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (_formKey.currentState!.validate()) {
      setState(() {
        load = true;
      });
      if (user != null) {
        // Updated address
        await user.updatePhotoURL(imageUrl);
      }

      await firebaseFirestore
          .collection("organizations")
          .doc("${widget.orgId}")
          .collection("supervisor")
          .doc("${user?.uid}")
          .update({
        "name": nameController.text,
        "designation": designationController.text,
        "phn1": phnController.text,
        "imgUrl": imageUrl,
      }).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OfficeHome(
                      orgId: widget.orgId,
                    )));
      }, onError: (error) {
        setState(() {
          load = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const SimpleCustomAlert("Something went Wrong, Try again!",
                  Colors.redAccent, "Error");
            });
        return Future.value(null); // Return a Future that resolves to null
      });
    }
  }
}
