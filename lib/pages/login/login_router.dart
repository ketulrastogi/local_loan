import 'package:flutter/material.dart';
import 'package:local_loan/pages/home/home.dart';
import 'package:local_loan/pages/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRouter {
  isAuthenticated(BuildContext context) async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString('userId');

    // Future.delayed(Duration(seconds: 3), (){

      if(userId != '' || userId != null){
        Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => HomePage()
      ),);
      }else {
        Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => LoginPage()
      ),);
      }
      
    // });
  }
}