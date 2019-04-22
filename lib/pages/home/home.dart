import 'package:flutter/material.dart';
import 'package:local_loan/pages/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userName;

  @override
  void initState() {
    super.initState();
    isProfileUpdated();
  }

  isProfileUpdated() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userName = sharedPreferences.getString('userName');

    if(userName != '' || userName != null){
        Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => ProfilePage()
      ),);
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Local Loan'),
        ),
        body: Container(
          child: Center(
            child: Text('Hello $userName'),
          ),
        ),
        drawer: Drawer(
          elevation: 5.0,
          child: Container(
            child: Center(
              child: Text('SideMenu'),
            ),
          ),
        ),
      ),
    );
  }
}