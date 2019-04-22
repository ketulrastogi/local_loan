import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String userName;

  @override
  void initState() { 
    super.initState();
    isProfileUpdated();
  }

  isProfileUpdated() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userName = sharedPreferences.getString('userName');

    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Profile'),),
        body: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Text('Hello $userName'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}