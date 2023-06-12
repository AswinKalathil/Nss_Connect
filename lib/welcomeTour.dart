import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nss_connect/HomeDasboard.dart';
import 'package:nss_connect/pageTrasitions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'intro_screens/intro_screen_1.dart';
import 'intro_screens/intro_screen_2.dart';
import 'intro_screens/intro_screen_3.dart';


class WelcomeTour extends StatefulWidget {
  const WelcomeTour({super.key});
  static const String id = 'welcomeScreen';

  @override
  State<WelcomeTour> createState() => _WelcomeTourState();
}

class _WelcomeTourState extends State<WelcomeTour> {
  PageController _controller = PageController();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (_) async {
      if (_controller.page == 2) {
        _timer?.cancel();
        await Future.delayed(Duration(seconds: 1));

        nextPage(context, HomeDashboard());
        
      } else {
        //
        _controller.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              introscreen1(),
              introscreen2(),
              introscreen3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: SmoothPageIndicator(controller: _controller, count: 3),
          ),
          Container(
            alignment: const Alignment(.7, 0.75),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeDashboard()),
                );
                // nextPage(context, HomeDashboard());
              },
              child: Text('Skip'),
            ),
          ),
        ],
      ),
    );
  }
}