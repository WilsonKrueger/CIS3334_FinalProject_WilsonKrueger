import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication.dart';
import 'player.dart';
import 'player_display.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basketball Stats',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CollectionReference
      playerCollectionDB; // = FirebaseFirestore.instance.collection('PLAYERS');

  final TextEditingController _newNameTextField = TextEditingController();
  final TextEditingController _newNumberTextField = TextEditingController();

  String userID;
  Authentication authentication = new Authentication();

  Widget nameTextFieldWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 25,
      child: TextField(
        controller: _newNameTextField,
        textCapitalization: TextCapitalization
            .words, //Retrieved this line from https://stackoverflow.com/questions/49238908/flutter-textfield-value-always-uppercase-debounce
        style: TextStyle(fontSize: 22, color: Colors.black),
        decoration: InputDecoration(
          hintText: "Player Name",
          hintStyle: TextStyle(fontSize: 22, color: Colors.grey),
        ),
      ),
    );
  }

  Widget numberTextFieldWidget() {
    return SizedBox(
      width: 90,
      child: TextField(
          controller: _newNumberTextField,
          keyboardType: TextInputType
              .number, //Retrieved this line from https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter
          style: TextStyle(fontSize: 22, color: Colors.black),
          decoration: InputDecoration(
            hintText: "Number",
            hintStyle: TextStyle(fontSize: 22, color: Colors.grey),
          )),
    );
  }

  Widget addButtonWidget() {
    return SizedBox(
      child: ElevatedButton(
          onPressed: () {
            setState(() async {
              Player player = new Player();
              player.setName(_newNameTextField.text);
              player.setNumber(int.parse(_newNumberTextField.text));
              player.zeroPlayer();
              //team.add(new Player(_newNameTextField.text, _newNumberTextField.text));
              await playerCollectionDB.add({'Player': player.toJson()});
              _newNumberTextField.clear();
              _newNameTextField.clear();
            });
          },
          child: Text(
            'Add Player',
            style: TextStyle(fontSize: 20),
          )),
    );
  }

  Widget playerInputWidget() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nameTextFieldWidget(),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            numberTextFieldWidget(),
            SizedBox(
              width: 120,
            ),
            addButtonWidget(),
          ],
        ),
      ],
    );
  }

  Widget playerTileWidget(snapshot, position) {
    Map<String, dynamic> playerListMap = snapshot.data.docs[position]['Player'];
    Player player = Player.fromJson(playerListMap);
    return ListTile(
      leading: Icon(Icons.sports_basketball),
      title: Text(player.getDescription()),
      onTap: () {
        setState(() async {
          String playerID = snapshot.data.docs[position].id;
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlayerDisplay(
                        playerID: playerID,
                      )));
        });
      },
      trailing: ElevatedButton(
        child: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            String playerId = snapshot.data.docs[position].id;
            playerCollectionDB.doc(playerId).delete();
            //team.removeAt(position);
          });
        },
      ),
    );
  }

  Widget playerListWidget() {
    return Expanded(
        child: StreamBuilder(
            stream: playerCollectionDB.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                // initially we won't have the Firestore data.  Only display the list once the async call returns data
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int position) {
                      return Card(child: playerTileWidget(snapshot, position));
                    });
              } else {
                return Text("Getting data from the cloud");
              }
            }));
  }

  Widget mainScreen() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            playerInputWidget(),
            SizedBox(
              height: 40,
            ),
            playerListWidget(),
            logoutButton(),
          ],
        ),
      ),
    );
  }

  Widget loginScreen() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text("Not Logged in"),
            ElevatedButton(
                onPressed: () async {
                  await authentication.signInWithGoogle();
                  userID = authentication.getUserID();
                },
                child: Text(
                  'Log in with Google',
                  style: TextStyle(fontSize: 20),
                )),
            logoutButton(),
          ],
        ),
      ),
    );
  }

  Widget logoutButton() {
    return ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
        child: Text(
          'Logout',
          style: TextStyle(fontSize: 20),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          print("Main builder -- User exists");
          userID = FirebaseAuth.instance.currentUser.uid;
          playerCollectionDB = FirebaseFirestore.instance
              .collection('USERS')
              .doc(userID)
              .collection('PLAYERS');
          return mainScreen();
        } else {
          print("Main builder -- need to login");
          return loginScreen();
        }
      },
    );
  }
}
