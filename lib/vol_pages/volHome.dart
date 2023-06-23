import 'package:flutter/material.dart';
import 'package:nss_connect/Sec_Pages/SecHome.dart';
import 'package:nss_connect/widgetStyles.dart';
import 'package:percent_indicator/percent_indicator.dart';

class VolHome extends StatefulWidget {
  const VolHome({super.key, required this.AttendencePercent});
  final double AttendencePercent;
  @override
  State<VolHome> createState() => _VolHomeState();
}

class _VolHomeState extends State<VolHome> {
  @override
  Widget build(BuildContext context) {
    double width100 = MediaQuery.of(context).size.width;
    double height100 = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Container(
      child: Column(children: [
        Expanded(
            child: SizedBox(
          height: height100 * .3,
          width: width100 * .95,
          child: Card(
            elevation: 5,
            shape: CardShape(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 10.0,
                    header: Container(
                        padding: EdgeInsets.all(20),
                        height: height100 * .1,
                        child: Text(
                          'Attendence',
                          style: TextStyle(fontSize: 20),
                        )),
                    percent: widget.AttendencePercent,
                    center: new Text("${widget.AttendencePercent * 100}%"),
                    progressColor: widget.AttendencePercent >= .75
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("${widget.AttendencePercent * 100}/100"),
                )
              ],
            ),
          ),
        )),
        Expanded(
            child: Container(
          color: Colors.grey.shade200,
          width: width100 * .98,
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, index) {
                return Card(
                    child: SizedBox(
                        height: height100 * .1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Message: ${index + 1}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        )));
              }),
        )),
      ]),
    );
  }
}
