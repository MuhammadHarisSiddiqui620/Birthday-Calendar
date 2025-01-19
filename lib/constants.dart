import 'package:flutter/material.dart';

const primaryTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const secondaryTextStyle = TextStyle(
    color: Color(0xFF202020),
    fontSize: 40,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w700);

final primaryButton = ElevatedButton.styleFrom(
  minimumSize: Size(355, 52),
  backgroundColor: Color(0xFF152C8D), // make button background transparent
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
);

const thirdlyTextStyle = TextStyle(
    color: Color(0xFF202020),
    fontSize: 18,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const searchText = TextStyle(
    color: Color(0xFF000000),
    fontSize: 17,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w300);

const birthdaySecondaryText = TextStyle(
    color: Color(0xFF000000),
    fontSize: 16,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const birthdayFirstText = TextStyle(
    color: Color(0xFF000000),
    fontSize: 16,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w600);

const postCardInputText = TextStyle(
    color: Color(0xFF000000),
    fontSize: 13,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);

const miniCalendorDate = TextStyle(
    color: Color(0xFF24252C),
    fontSize: 14,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w800);

const mainScreenText = TextStyle(
    color: Colors.black,
    fontSize: 25,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w500);
