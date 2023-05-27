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
  late String imageUrl = "https://i.ibb.co/m5jpbF4/727091-Account-manager.png";

  // form
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController phnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //name field
    final namefield = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Feild Cannot be empty");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Full Name",
        labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    //designation field
    final designationfield = TextFormField(
      autofocus: false,
      controller: designationController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        designationController.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your designation");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Designation",
        labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    //phn1 field
    final phnfield = TextFormField(
      autofocus: false,
      controller: phnController,
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        phnController.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your Phone Number");
        } else if (value.length != 10) {
          return ("invalid Phone Number");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Phone Number 1",
        labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    "Create Profile",
                    style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: white,
                      backgroundImage: NetworkImage(imageUrl),
                    )),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      namefield,
                      const SizedBox(
                        height: 35,
                      ),
                      designationfield,
                      const SizedBox(
                        height: 35,
                      ),
                      phnfield,
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    // padding: const EdgeInsets.symmetric(horizontal: 50),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploadData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 35,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return ("Feild Cannot be empty");
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: labelText,
          labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void uploadData() async {
    // TODO : Add Loading

    final user = FirebaseAuth.instance.currentUser;

    if (_formKey.currentState!.validate()) {

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
            context, MaterialPageRoute(builder: (context) => OfficeHome(orgId: widget.orgId,)));
      }, onError: (error) {
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
