
import 'package:flutter/widgets.dart';

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

  Player(this._name, this._number)
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
  }

  String getDescription() {
    return _number + " " + _name;
  }
}