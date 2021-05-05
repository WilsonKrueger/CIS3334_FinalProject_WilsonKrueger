import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'player.dart';

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
        primarySwatch: Colors.blue,
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
  //List<Player> team = [];
  final CollectionReference playerCollectionDB = FirebaseFirestore.instance.collection('PLAYERS');

  final TextEditingController _newNameTextField = TextEditingController();
  final TextEditingController _newNumberTextField = TextEditingController();

  _MyHomePageState() {
/*    team.add(new Player("Chris Paul", 0));
    team.add(new Player("Lebron James", "23"));
    team.add(new Player("Donovan Mitchell ", "45"));
    team.add(new Player("Kawhi Leonard", "2"));*/
  }

  Widget nameTextFieldWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 25,
      child: TextField(
        controller: _newNameTextField,
        textCapitalization: TextCapitalization.words,           //Retrieved this line from https://stackoverflow.com/questions/49238908/flutter-textfield-value-always-uppercase-debounce
        style: TextStyle(fontSize: 22, color: Colors.black),
        decoration: InputDecoration(
          hintText: "Player Name",
          hintStyle: TextStyle(fontSize: 22, color: Colors.grey),
        ),
      ),
    );
  }

  Widget numberTextFieldWidget() {
    return SizedBox (
      width: 90,
      child: TextField (
        controller: _newNumberTextField,
        keyboardType: TextInputType.number,                     //Retrieved this line from https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter
        style: TextStyle(fontSize: 22, color: Colors.black),
        decoration: InputDecoration(
          hintText: "Number",
          hintStyle: TextStyle(fontSize: 22, color: Colors.grey),
      )
    ),
    );
  }

  Widget addButtonWidget() {
    return SizedBox(
      child: ElevatedButton(
          onPressed: () {
            setState(() async {
              Player player = new Player();//_newNameTextField.text, _newNumberTextField.text);
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
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            numberTextFieldWidget(),
            SizedBox(width: 120,),
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
        trailing: ElevatedButton (
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

/*  Widget playerListWidget() {
    return Expanded(
      child:
        ListView.builder(
          itemCount: team.length,
          itemBuilder: (BuildContext context, int position) {
            return Card(
                child: playerTileWidget(position)
            );
          }
        ),
    );
  }*/

  Widget playerListWidget() {
    return Expanded(
        child:
        StreamBuilder(stream: playerCollectionDB.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {             // initially we won't have the Firestore data.  Only display the list once the async call returns data
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int position) {
                      return Card(
                          child: playerTileWidget(snapshot,position)
                      );
                    }
                );
              } else {
                return Text("Getting data from the cloud");
              }
            })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            playerInputWidget(),
            SizedBox(height: 40,),
            playerListWidget(),
          ],
        ),
      ),
    );
  }
}

