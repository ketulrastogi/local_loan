import 'package:flutter/material.dart';

@immutable
class User {
  final String uid;
  final String name;
  final String phoneNumber;
  final String bloodGroup;
  final bool isBloodDonor;

  const User({
    @required this.uid,
    @required this.phoneNumber,
    this.name,
    this.bloodGroup,
    this.isBloodDonor
  });
}