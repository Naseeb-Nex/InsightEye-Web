import 'package:glassmorphism/glassmorphism.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../wrapper/homewrapper.dart';

class LoginSrc extends StatefulWidget {
  const LoginSrc({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginSrcState createState() => _LoginSrcState();
}

class _LoginSrcState extends State<LoginSrc> {
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onFieldSubmitted: (value) =>
          signIn(emailController.text, passwordController.text),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: TextButton(
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );

    // Responsive Size
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/web-bg.png",
                ),
                fit: BoxFit.fill)),
        child: Stack(children: [
          Center(
            child: SingleChildScrollView(
              child: Center(
                // child: Container(
                //   padding: const EdgeInsets.all(30),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       color: Colors.white),
                //   width: MediaQuery.of(context).size.width / 3,
                //   child: Form(
                //     key: _formKey,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: <Widget>[
                //         SizedBox(
                //             height: 100,
                //             width: 150,
                //             child: Image.asset(
                //               "assets/icons/appicon.png",
                //               fit: BoxFit.contain,
                //               filterQuality: FilterQuality.high,
                //             )),
                //         const SizedBox(height: 45),
                //         emailField,
                //         const SizedBox(height: 25),
                //         passwordField,
                //         const SizedBox(height: 35),
                //         loginButton,
                //       ],
                //     ),
                //   ),
                // ),
                // child: Container(
                //   width: s.width * 0.70,
                //   height: s.height * 0.7578,
                //   decoration: BoxDecoration(
                //     color: white.withOpacity(0.01)
                //   ),
                // )
                child: GlassmorphicContainer(
                  width: s.width * 0.70,
                  height: s.height * 0.7578,
                  borderRadius: 20,
                  blur: 1,
                  alignment: Alignment.bottomCenter,
                  border: 1,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFFFEFE).withOpacity(0.1),
                        const Color(0xFFFFFEFE).withOpacity(0.05),
                      ],
                      stops: const [
                        0.1,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.5),
                      const Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  child: Row(
                    children: [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: s.width * 0.0425,
                              bottom: s.width * 0.0425,
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                 Text(
                                  "Welcome,",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 35,
                                    color: white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                 Text(
                                  "InsightEye",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 35,
                                    color: white,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                 Text(
                                  "Innovators!",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 35,
                                    color: white,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(height: 10 ,),
                                 Text(
                                  "Login to  acess your Account",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 20,
                                    color: white,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                              color: white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Login",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 40,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: s.height * 0.05859,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: s.width * 0.05555),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            autofocus: false,
                                            controller: emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return ("Please Enter Your Email");
                                              }
                                              // reg expression for email validation
                                              if (!RegExp(
                                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                                  .hasMatch(value)) {
                                                return ("Please Enter a valid email");
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              emailController.text = value!;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              labelText: "Email Id",
                                              labelStyle: const TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                color: Colors.blueGrey,
                                              ),
                                              fillColor: Colors.white,
                                              filled: true,
                                              errorStyle: const TextStyle(
                                                  fontFamily: "Montserrat"),
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.blueGrey)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey.shade400)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: const BorderSide(
                                                      color: Color(0XFFff0a54),
                                                      width: 2.0)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color(
                                                                  0XFFff4d6d),
                                                              width: 2.0)),
                                            ),
                                            style: const TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 15,
                                              color: black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            autofocus: false,
                                            controller: passwordController,
                                            obscureText: true,
                                            validator: (value) {
                                              RegExp regex = RegExp(r'^.{6,}$');
                                              if (value!.isEmpty) {
                                                return ("Password is required for login");
                                              }
                                              if (!regex.hasMatch(value)) {
                                                return ("Enter Valid Password(Min. 6 Character)");
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              passwordController.text = value!;
                                            },
                                            textInputAction:
                                                TextInputAction.done,
                                            onFieldSubmitted: (value) => signIn(
                                                emailController.text,
                                                passwordController.text),
                                            decoration: InputDecoration(
                                              labelText: "Password",
                                              labelStyle: const TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                color: Colors.blueGrey,
                                              ),
                                              fillColor: Colors.white,
                                              filled: true,
                                              errorStyle: const TextStyle(
                                                  fontFamily: "Montserrat"),
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.blueGrey)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey.shade400)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: const BorderSide(
                                                      color: Color(0XFFff0a54),
                                                      width: 2.0)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color(
                                                                  0XFFff4d6d),
                                                              width: 2.0)),
                                            ),
                                            style: const TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 15,
                                              color: black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: s.height * 0.05859,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurple.shade300,
                                              gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                stops: [0.0, 1.0],
                                                colors: [
                                                  Color(0XFF7A43AB),
                                                  Color(0XFF57308D),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(0, 4),
                                                    blurRadius: 5.0)
                                              ],
                                            ),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        const Size(50, 50)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                shadowColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        40, 10, 40, 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Login'.toUpperCase(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Montserrat"),
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
                                                                    color:
                                                                        white))
                                                            : null),
                                                  ],
                                                ),
                                              ),
                                              onPressed: () {
                                                signIn(emailController.text,
                                                    passwordController.text);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: load
                ? const CircularProgressIndicator(
                    color: Color(0XFF7A43AB),
                  )
                : null,
          )
        ]),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    // firebase
    // if (_formKey.currentState!.validate()) {
    setState(() {
      load = true;
    });
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: "naseeb@gmail.com", password: "12345678")
          // .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeWrapper())),
              });
    } on FirebaseAuthException catch (error) {
      setState(() {
        load = false;
      });
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "invalid-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User Not Found.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Please try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "Your password or Email is wrong.";
      }

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleCustomAlert("$errorMessage");
          });
    }
    // catch (error) {
    //   setState(() {
    //     load = false;
    //   });
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return const SimpleCustomAlert("Email or Password is incorrect!");
    //       });
    // }
    // }
  }
}

class SimpleCustomAlert extends StatelessWidget {
  final String title;
  const SimpleCustomAlert(this.title, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.redAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        height: 200,
        width: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: primarybg,
                    size: 30,
                  ),
                  Text(
                    " Error",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Nunito",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(white),
              ),
              child: const Text(
                "Okay",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
