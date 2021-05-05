
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