import 'package:flutter/material.dart';
import 'package:insighteye_web/constants/constants.dart';

// ignore: must_be_immutable
class SchedulePgmSrc extends StatefulWidget {
  String? uid;
  String? techuid;
  String? techname;
  SchedulePgmSrc({Key? key, this.uid, this.techuid, this.techname})
      : super(key: key);

  @override
  SchedulePgmSrcState createState() => SchedulePgmSrcState();
}

class SchedulePgmSrcState extends State<SchedulePgmSrc> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: s.width * 0.015),
            color: bluebg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: s.width * 0.015,
                ),
                const Text(
                  "Schedule Program",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: white,
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(
                  height: s.width * 0.015,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left : 10),
                      child: Column(
                        children: [
                          Text(
                            "Schedule Program",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: white,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "View Schedules",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white,
                            letterSpacing: -1,
                          ),
                        ),
                        Divider(
                          color: white,
                          thickness: 3,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
