// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/cookie_widget.dart';

class CookieOrder {
  String id;
  num ingredient1;
  num ingredient2;
  num ingredient3;
  late num totalTime;
  late CookieWidget cookieWidget = CookieWidget(title: '$id');
  late Offset positionOfTheRequest = const Offset(0, 0);
  bool isSweet;
  late num timeConstant = 0.0;
  late bool inMovement = false;
  late String userEmail;
  late bool isDone = true;
  int cookieSweet = 0;
  int cookieSalty = 0;

  CookieOrder({
    required this.ingredient1,
    required this.ingredient2,
    required this.ingredient3,
    required this.isSweet,
    required this.cookieWidget,
    required this.id,
    this.totalTime = 0.0,
    required this.timeConstant,
    required this.userEmail,
    required this.isDone,
  });

  Future<String> getUser() async {
    String? userEmail = await FirebaseAuth.instance.currentUser?.email;
    userEmail != null ? userEmail = userEmail : userEmail = '';
    return userEmail;
  }

  double calculateCookingTime(double T) {
    //calcula o tempo proporcional aos ingredientes e com o fator do tipo
    return isSweet
        ? 1.2 * (ingredient1 + ingredient2 + ingredient3) * T
        : 1.0 * (ingredient1 + ingredient2 + ingredient3) * T;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ingredient1': ingredient1,
      'ingredient2': ingredient2,
      'ingredient3': ingredient3,
      'isSweet': isSweet,
      'cookieWidget': cookieWidget.toJson(),
      'userEmail': userEmail,
      'totalTime': totalTime,
      'timeConstant': timeConstant,
      'line': '',
      'isDone': isDone,
    };
  }

  factory CookieOrder.fromJson(Map<String, dynamic> json) {
    return CookieOrder(
      id: json['id'] as String,
      ingredient1: json['ingredient1'] as num,
      ingredient2: json['ingredient2'] as num,
      ingredient3: json['ingredient3'] as num,
      totalTime: json['totalTime'] as num,
      cookieWidget: json['cookieWidget'] is String
          ? CookieWidget.fromJson(jsonDecode(json['cookieWidget']))
          : CookieWidget.fromJson(json['cookieWidget']),
      isSweet: json['isSweet'] as bool,
      timeConstant: json['timeConstant'] as num,
      userEmail: json['userEmail'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  factory CookieOrder.fromMap(Map<String, dynamic> map) {
    return CookieOrder(
      id: map['id'] as String,
      ingredient1: map['ingredient1'] as num,
      ingredient2: map['ingredient2'] as num,
      ingredient3: map['ingredient3'] as num,
      isSweet: map['isSweet'] as bool,
      timeConstant: 1,
      cookieWidget: CookieWidget(title: map['id'] as String),
      userEmail: map['userEmail'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() => toMap();
}
