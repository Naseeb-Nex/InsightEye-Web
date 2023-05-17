import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late VideoPlayerController _controller;

  bool isVid = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('assets/Vedio/bg_vedio.mp4')
      // 'https://github.com/Naseeb-Nex/InsightEye-Web/blob/main/assets/Vedio/bg_vedio.mp4')
      ..initialize().then((_) {
        _controller.setVolume(0);
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
        // _controller.play();
        // _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          isVid = true;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: isVid
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: GlassmorphicContainer(
                  width: 470,
                  height: 500,
                  borderRadius: 20,
                  blur: 100,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFD9E4F0).withOpacity(0.3),
                      const Color(0xFFE3EAF5).withOpacity(0.5),
                    ],
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      const Color(0xFFD9E4F0).withOpacity(0.3),
                      const Color(0xFFE3EAF5).withOpacity(0.5),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade50),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple,
                                spreadRadius: 2,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () => print("it's pressed"),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0XFFcd00ff),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                    child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
