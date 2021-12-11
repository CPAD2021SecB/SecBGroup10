import 'dart:async';

import 'package:breview/pages/home_page.dart';
import 'package:breview/pages/login_page.dart';
import 'package:breview/provider/LoginProvider.dart';
import 'package:breview/util/RouteAnimation.dart';
import "package:flutter/material.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription _streamSubscription;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    LoginProvider.instantiate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 1000), () {
      checkLoginStatus(_scaffoldKey.currentContext);
    });

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 200,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/splash.jpg",
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
              ))),
    );
  }

  void checkLoginStatus(BuildContext navcontext) {
    _streamSubscription = LoginProvider.stateStream.listen((state) {
      if (state == PhoneAuthState.Failed || state == PhoneAuthState.newUser) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(_scaffoldKey.currentContext)
              .pushReplacement(FadeRoute(page: PhoneloginWidget()));
        });
      }
      if (state == PhoneAuthState.Verified) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(navcontext).pushReplacement(FadeRoute(page: HomePage()));
        });
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _streamSubscription = null;
    super.dispose();
  }
}
