
import 'package:flutter/widgets.dart';

// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

//Retrieved from https://app.quicktype.io/

import 'dart:convert';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
  Player({
    this.name,
    this.number,
    this.points,
    this.fieldGoalsMade,
    this.fieldGoalsAttempted,
    this.fieldGoalPercentage,
    this.rebounds,
    this.assists,
    this.steals,
    this.blocks,
    this.fouls,
  });


  String name;
  int number;
  int points;
  int fieldGoalsMade;
  int fieldGoalsAttempted;
  int fieldGoalPercentage;
  int rebounds;
  int assists;
  int steals;
  int blocks;
  int fouls;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    name: json["name"],
    number: json["number"],
    points: json["points"],
    fieldGoalsMade: json["fieldGoalsMade"],
    fieldGoalsAttempted: json["fieldGoalsAttempted"],
    fieldGoalPercentage: json["fieldGoalPercentage"],
    rebounds: json["rebounds"],
    assists: json["assists"],
    steals: json["steals"],
    blocks: json["blocks"],
    fouls: json["fouls"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "number": number,
    "points": points,
    "fieldGoalsMade": fieldGoalsMade,
    "fieldGoalsAttempted": fieldGoalsAttempted,
    "fieldGoalPercentage": fieldGoalPercentage,
    "rebounds": rebounds,
    "assists": assists,
    "steals": steals,
    "blocks": blocks,
    "fouls": fouls,
  };

  setName(String value) {
    name = value;
  }

  setNumber(int value) {
    number = value;
  }

  String getDescription() {
    return number.toString() + " " + name;
  }

  zeroPlayer() {
    points = 0;
    fieldGoalsMade = 0;
    fieldGoalsAttempted = 0;
    fieldGoalPercentage = 0;
    rebounds = 0;
    assists = 0;
    steals = 0;
    blocks = 0;
    fouls = 0;
  }

}



/*
class Player {
  String _name;
  String _number;
  Image _image;
  int _points;
  int _fieldGoalsMade;
  int _fieldGoalsAttempted;
  double _fieldGoalPercentage;
  int _rebounds;
  int _assists;
  int _steals;
  int _blocks;
  int _fouls;

  Player()
  {
    _name = "";
    _number = "0";
    _points = 0;
    _fieldGoalsMade = 0;
    _fieldGoalsAttempted = 0;
    _fieldGoalPercentage = 0;
    _rebounds = 0;
    _assists = 0;
    _steals = 0;
    _blocks = 0;
    _fouls = 0;
  }

  /*Player(this._name, this._number)
  {
    _points = 0;
    _fieldGoalsMade = 0;
    _fieldGoalsAttempted = 0;
    _fieldGoalPercentage = 0;
    _rebounds = 0;
    _assists = 0;
    _steals = 0;
    _blocks = 0;
    _fouls = 0;
  }*/

  String getDescription() {
    return _number + " " + _name;
  }

  String get name => _name;

  setName(String value) {
    _name = value;
  }

  String get number => _number;

  set number(String value) {
    _number = value;
  }

  Image get image => _image;

  set image(Image value) {
    _image = value;
  }

  int get points => _points;

  set points(int value) {
    _points = value;
  }

  int get fieldGoalsMade => _fieldGoalsMade;

  set fieldGoalsMade(int value) {
    _fieldGoalsMade = value;
  }

  int get fieldGoalsAttempted => _fieldGoalsAttempted;

  set fieldGoalsAttempted(int value) {
    _fieldGoalsAttempted = value;
  }

  double get fieldGoalPercentage => _fieldGoalPercentage;

  set fieldGoalPercentage(double value) {
    _fieldGoalPercentage = value;
  }

  int get rebounds => _rebounds;

  set rebounds(int value) {
    _rebounds = value;
  }

  int get assists => _assists;

  set assists(int value) {
    _assists = value;
  }

  int get steals => _steals;

  set steals(int value) {
    _steals = value;
  }

  int get blocks => _blocks;

  set blocks(int value) {
    _blocks = value;
  }

  int get fouls => _fouls;

  set fouls(int value) {
    _fouls = value;
  }
}
*/