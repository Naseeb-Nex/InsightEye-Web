import 'package:flutter/material.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:insighteye_web/componets/vscroll.dart';
import 'package:insighteye_web/wrapper/completed_pgm_wrapper.dart';

class Completedpgmviewer extends StatelessWidget {
  String? orgId;
  Completedpgmviewer({Key? key, this.orgId}) : super(key: key);
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 15,
                  color: secondbg.withOpacity(0.20),
                ),
              ],
              color: primarybg),
          child: ScrollConfiguration(
            behavior: Vscroll(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Completedpgmwrapper(orgId: orgId),
            ),
          ),
        ),
      ),
    );
  }
}
