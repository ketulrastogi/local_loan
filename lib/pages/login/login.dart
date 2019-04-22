import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_loan/models/user.dart';
import 'package:local_loan/pages/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _verifyPhoneKey =
      GlobalKey<FormState>(debugLabel: '_verifyPhoneKey');
  final GlobalKey<FormState> _verifySmsCodeKey =
      GlobalKey<FormState>(debugLabel: '_verifySmsCodeKey');

  String _phoneNumber, _verificationId, _smsCode, _authState = 'VERIFYPHONE';

  User user;
  
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: loginPageSection(),
        ),
      ),
    );
  }

  Widget loginPageSection() {
    if(_authState == 'VERIFYSMSCODE'){
      return verifySmsCodeSection();
    }
    return verifyPhoneSection();
  }

  Widget verifyPhoneSection() {
    // var height = MediaQuery.of(context).size.height / 3;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: <Widget>[
        Container(
          height: 100.0,
          child: Center(
            child: Text(
              'Verify Phone Number',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.grey[800]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80.0,
            child: Center(
              child: Text(
                'Let\'s Start with your phone number. We will send 6 digit sms code to verify.',
                style: TextStyle(
                    fontSize: 16.0,
                    // fontWeight: FontWeight.w400,
                    color: Colors.grey[700]),
              ),
            ),
          ),
        ),
        Container(
          height: 100.0,
          child: Row(
            children: <Widget>[
              Flexible(
                child: Form(
                  key: _verifyPhoneKey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.0),
                      boxShadow: [BoxShadow(
                        color: Colors.blueGrey[100],
                        blurRadius: 24.0
                      )]
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide.none
                        ),
                        hintText: 'Phone number',
                        prefixText: '+91 '
                      ),
                      validator: (val) {
                        if (val.length != 10) {
                          return "Phone number must be of 10 digits";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          this._phoneNumber = '+91' + value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0,),
              FloatingActionButton(
                // padding: EdgeInsets.symmetric(vertical:24.0),
                child: Icon(
                  // Icons.keyboard_arrow_right,
                  Icons.check
                ),
                // color: Colors.red,
                onPressed: () {
                  if(_verifyPhoneKey.currentState.validate()){
                    _verifyPhoneKey.currentState.save();
                    verifyPhoneNumber(_phoneNumber);
                  }
                  
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (FirebaseUser firebaseUser) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      print('PhoneVerificationCompleted');
      user = User(uid: firebaseUser.uid, phoneNumber: firebaseUser.phoneNumber);
      sharedPreferences.setString('user', json.encode(user.toString()));
      Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => HomePage()
      ),);
    
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) async {
      print('PhoneVerificationFailed');
      print(authException.message);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print('PhoneCodeSent');
      // _verificationId = verificationId;
      Future.delayed(Duration(seconds: 5), (){
        print('Verify OTP after 5 seconds');
        setState(() {
         _verificationId = verificationId;
         _authState = 'VERIFYSMSCODE';
        });
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print('PhoneCodeAutoRetrievalTimeout');
      _verificationId = verificationId;
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 1),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }


  Widget verifySmsCodeSection() {
    // var height = MediaQuery.of(context).size.height / 3;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: <Widget>[
        Container(
          height: 100.0,
          child: Center(
            child: Text(
              'Verify SMS Code',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.grey[800]),
            ),
          ),
        ),
        Container(
          height: 80.0,
          child: Center(
            child: Text(
              'Enter 6 digit sms code to verify your identity.',
              style: TextStyle(
                  fontSize: 16.0,
                  // fontWeight: FontWeight.w400,
                  color: Colors.grey[700]),
            ),
          ),
        ),
        Container(
          height: 100.0,
          child: Row(
            children: <Widget>[
              Flexible(
                child: Form(
                  key: _verifySmsCodeKey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.0),
                      boxShadow: [BoxShadow(
                        color: Colors.blueGrey[100],
                        blurRadius: 24.0
                      )]
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide.none
                        ),
                        hintText: 'SMS Code',
                        prefixText: '  '
                      ),
                      validator: (val) {
                        if (val.length != 6) {
                          return "SMS Code must be of 6 digits";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          this._smsCode = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0,),
              FloatingActionButton(
                // padding: EdgeInsets.symmetric(vertical:24.0),
                child: Icon(
                  Icons.keyboard_arrow_right,
                ),
                // color: Colors.red,
                onPressed: () {
                  if(_verifySmsCodeKey.currentState.validate()){
                    _verifySmsCodeKey.currentState.save();
                    verifySmsCode(_verificationId, _smsCode);
                  }
                  
                },
              )
            ],
          ),
        ),
      ],
    );
  }



  verifySmsCode(String verificationId, String smsCode) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final FirebaseUser firebaseUser =
          await _firebaseAuth.signInWithCredential(credential);

      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      assert(firebaseUser.uid == currentUser.uid);
      user = User(uid: firebaseUser.uid, phoneNumber: firebaseUser.phoneNumber);

      sharedPreferences.setString('user', json.encode(user.toString()));

      Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => HomePage()
      ),);

    } on PlatformException catch (error) {
      print(error);
    }
  }

}
