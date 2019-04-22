import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_loan/pages/home/home.dart';
import 'package:local_loan/pages/login/login.dart';
import 'package:local_loan/pages/login/login_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), (){
      Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => LoginPage()
      ),);
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(16.0),
                height: 128.0,
                width: 128.0,
                child: SvgPicture.asset('assets/icons/money-bag.svg')),
            SizedBox(
              height: 16.0,
            ),
            Container(
              child: Center(
                child: Text(
                  'LOCAL LOAN APP',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[850]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
