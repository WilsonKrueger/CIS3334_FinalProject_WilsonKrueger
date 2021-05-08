
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
    this.rebounds,
    this.assists,
    this.steals,
    this.blocks,
    this.fouls,
  });


  String name;
  int number;
  int points;
  int rebounds;
  int assists;
  int steals;
  int blocks;
  int fouls;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    name: json["name"],
    number: json["number"],
    points: json["points"],
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
    rebounds = 0;
    assists = 0;
    steals = 0;
    blocks = 0;
    fouls = 0;
  }

}
