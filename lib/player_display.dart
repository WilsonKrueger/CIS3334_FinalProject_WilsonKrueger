import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // for Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart'; // for Firebase Firestore

import 'package:image_picker/image_picker.dart';

import 'player.dart';

class PlayerDisplay extends StatefulWidget {
  String playerID;
  // define a constructor that saves the position into the variable above
  @override
  PlayerDisplay({Key key, @required this.playerID}) : super(key: key);

  @override
  _PlayerDisplayState createState() => _PlayerDisplayState();
}

class _PlayerDisplayState extends State<PlayerDisplay> {
  String userID;
  String playerID;
  Player player;
  DocumentSnapshot documentSnapshot;
  DocumentReference playerFireStoreDoc;
  Map<String, dynamic> playerMap;
  Future<File> imageFile;
  Image image;

  @override
  initState() {
    userID = FirebaseAuth.instance.currentUser.uid;
    playerID =
        widget.playerID; // get player ID that was passed into this widget
    playerFireStoreDoc = FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .collection('PLAYERS')
        .doc(playerID);
    playerFireStoreDoc.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          playerMap = documentSnapshot.data()['Player'];
          player = Player.fromJson(playerMap);
        });
      }
    });
  }

  //Retrieved and modified image code from https://www.youtube.com/watch?v=aBoYbMBTu7s and https://stackoverflow.com/questions/58224596/convert-file-to-image
  Future getImage() async {
    final IMAGE = await ImagePicker.pickImage(source: ImageSource.gallery);
    image = await convertFileToImage(IMAGE);
    setState(() {});
  }

  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }

  Widget header() {
    return Column(
      children: [
        Text(
          player.name,
          style: TextStyle(fontSize: 35),
        ),
        Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: image == null ? Text("Select Image") : image,
            ),
            ElevatedButton(
              onPressed: getImage,
              child: Text("Select Headshot Image"),
            ),
          ],
        )
      ],
    );
  }

  Widget playerPoints() {
    return Column(
      children: [
        Text(
          "Points",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (player.points <= 0) {
                    return null;
                  } else {
                    setState(() {
                      player.points--;
                      playerFireStoreDoc.set({'Player': player.toJson()});
                    });
                  }
                },
                child: Icon(Icons.exposure_minus_1)),
            SizedBox(width: 25),
            Text(
              player.points.toString(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 25),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  player.points++;
                  playerFireStoreDoc.set({'Player': player.toJson()});
                });
              },
              child: Icon(Icons.plus_one),
            ),
          ],
        ),
      ],
    );
  }

  Widget playerFouls() {
    return Column(
      children: [
        Text(
          "Fouls",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (player.fouls <= 0) {
                    return null;
                  } else {
                    setState(() {
                      player.fouls--;
                      playerFireStoreDoc.set({'Player': player.toJson()});
                    });
                  }
                },
                child: Icon(Icons.exposure_minus_1)),
            SizedBox(width: 25),
            Text(
              player.fouls.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(width: 25),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  player.fouls++;
                  playerFireStoreDoc.set({'Player': player.toJson()});
                });
              },
              child: Icon(Icons.plus_one),
            ),
          ],
        ),
      ],
    );
  }

  Widget playerRebounds() {
    return Column(
      children: [
        Text(
          "Rebounds",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (player.rebounds <= 0) {
                    return null;
                  } else {
                    setState(() {
                      player.rebounds--;
                      playerFireStoreDoc.set({'Player': player.toJson()});
                    });
                  }
                },
                child: Icon(Icons.exposure_minus_1)),
            SizedBox(width: 25),
            Text(
              player.rebounds.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(width: 25),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  player.rebounds++;
                  playerFireStoreDoc.set({'Player': player.toJson()});
                });
              },
              child: Icon(Icons.plus_one),
            ),
          ],
        ),
      ],
    );
  }

  Widget playerAssists() {
    return Column(
      children: [
        Text(
          "Assists",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (player.assists <= 0) {
                    return null;
                  } else {
                    setState(() {
                      player.assists--;
                      playerFireStoreDoc.set({'Player': player.toJson()});
                    });
                  }
                },
                child: Icon(Icons.exposure_minus_1)),
            SizedBox(width: 25),
            Text(
              player.assists.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(width: 25),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  player.assists++;
                  playerFireStoreDoc.set({'Player': player.toJson()});
                });
              },
              child: Icon(Icons.plus_one),
            ),
          ],
        ),
      ],
    );
  }

  Widget playerSteals() {
    return Column(
      children: [
        Text(
          "Steals",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (player.steals <= 0) {
                    return null;
                  } else {
                    setState(() {
                      player.steals--;
                      playerFireStoreDoc.set({'Player': player.toJson()});
                    });
                  }
                },
                child: Icon(Icons.exposure_minus_1)),
            SizedBox(width: 25),
            Text(
              player.steals.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(width: 25),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  player.steals++;
                  playerFireStoreDoc.set({'Player': player.toJson()});
                });
              },
              child: Icon(Icons.plus_one),
            ),
          ],
        ),
      ],
    );
  }

  Widget playerBlocks() {
    return Column(
      children: [
        Text(
          "Blocks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (player.blocks <= 0) {
                    return null;
                  } else {
                    setState(() {
                      player.blocks--;
                      playerFireStoreDoc.set({'Player': player.toJson()});
                    });
                  }
                },
                child: Icon(Icons.exposure_minus_1)),
            SizedBox(width: 25),
            Text(
              player.blocks.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(width: 25),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  player.blocks++;
                  playerFireStoreDoc.set({'Player': player.toJson()});
                });
              },
              child: Icon(Icons.plus_one),
            ),
          ],
        ),
      ],
    );
  }

  Widget backButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Back'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player Details"),
      ),
      body: Column(
        children: [
          header(),
          SizedBox(height: 20),
          Flexible(      //Code explanation from https://api.flutter.dev/flutter/widgets/Flexible-class.html
            fit: FlexFit.loose,
            child: Column(
              children: [
                playerPoints(),
                playerFouls(),
                playerRebounds(),
                playerAssists(),
                playerSteals(),
                playerBlocks(),
                backButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
