import 'package:flutter/material.dart';
import 'package:insighteye_web/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

import 'package:insighteye_web/widgets/Techview/techcompleted/techcday.dart';
import 'package:insighteye_web/widgets/Techview/techcompleted/techcmonth.dart';

// ignore: must_be_immutable
class Techcompleted extends StatefulWidget {
  String? uid;
  String? techuid;
  String? techname;
  String? orgId;

  Techcompleted({Key? key, this.uid, this.techuid, this.techname, this.orgId})
      : super(key: key);

  @override
  _TechcompletedState createState() => _TechcompletedState();
}

class _TechcompletedState extends State<Techcompleted> {
  String? _selectedmonth;
  String year = "2022";
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    setState(() {
      _selectedmonth = DateFormat('MM y').format(now);
      year = DateFormat('y').format(now);
    });
  }

  String _currentsw = "day";

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> categorylist = [
      "01 $year",
      "02 $year",
      "03 $year",
      "04 $year",
      "05 $year",
      "06 $year",
      "07 $year",
      "08 $year",
      "09 $year",
      "10 $year",
      "11 $year",
      "12 $year",
    ];
    return categorylist
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final monthsel = InputDecorator(
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.date_range_rounded,
          color: white,
        ),
        contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        hintText: "Month",
        border: InputBorder.none,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _selectedmonth,
          items: _dropDownItem(),
          onChanged: (value) {
            setState(() {
              _selectedmonth = value;
            });
          },
          hint: const Text(
            "Select Month",
            style: TextStyle(color: white, fontFamily: "Montserrat"),
          ),
          elevation: 12,
          style: const TextStyle(fontSize: 16, fontFamily: "Montserrat"),
          icon: const Icon(
            Icons.arrow_drop_down_circle,
            color: white,
          ),
          iconDisabledColor: Colors.white60,
          iconEnabledColor: bluebg,
          isExpanded: true,
        ),
      ),
    );

    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ScrollConfiguration(
            behavior: Techcswipe(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      _currentsw = 'day';
                    }),
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: _currentsw == "day"
                            ? white
                            : const Color(0xff560bad),
                        border: Border.all(color: const Color(0xff560bad)),
                      ),
                      child: Text(
                        "Day",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: _currentsw == "day"
                              ? const Color(0xff560bad)
                              : white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      _currentsw = 'month';
                    }),
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: _currentsw == "month"
                            ? white
                            : const Color(0xff560bad),
                        border: Border.all(color: const Color(0xff560bad)),
                      ),
                      child: Text(
                        "Month",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: _currentsw == "month"
                              ? const Color(0xff560bad)
                              : white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: _currentsw == "month"
                        ? Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff560bad),
                            ),
                            child: monthsel,
                          )
                        : null,
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Ctechwrapper(
                orgId: widget.orgId,
                currentsw: _currentsw,
                uid: widget.uid,
                techuid: widget.techuid,
                techname: widget.techname,
                cmonth: _selectedmonth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Techcswipe extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

// ignore: must_be_immutable
class Ctechwrapper extends StatelessWidget {
  String? currentsw;
  String? uid;
  String? techuid;
  String? techname;
  String? cmonth;
  String? orgId;

  Ctechwrapper(
      {Key? key,
      this.currentsw,
      this.uid,
      this.techuid,
      this.techname,
      this.cmonth,
      this.orgId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentsw == 'month') {
      return Techcmonth(
          uid: uid, techuid: techuid, techname: techname, cmonth: cmonth, orgId: orgId);
    }
    return Techcday(uid: uid, techuid: techuid, techname: techname, orgId: orgId);
  }
}
