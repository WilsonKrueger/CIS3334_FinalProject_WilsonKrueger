import 'package:flutter/material.dart';

import 'player.dart';

void main() {
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
  List<Player> team = [];
  final TextEditingController _newNameTextField = TextEditingController();
  final TextEditingController _newNumberTextField = TextEditingController();

  _MyHomePageState() {
    team.add(new Player("Chris Paul", "3"));
    team.add(new Player("Lebron James", "23"));
    team.add(new Player("Donovan Mitchell ", "45"));
    team.add(new Player("Kawhi Leonard", "2"));
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
            setState(() {
              team.add(new Player(_newNameTextField.text, _newNumberTextField.text));
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

  Widget playerTileWidget(position) {
    return ListTile(
        leading: Icon(Icons.sports_basketball),
        title: Text(team[position].getDescription()),
        trailing: ElevatedButton (
          child: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              team.removeAt(position);
            });
          },
        ),
    );
  }

  Widget playerListWidget() {
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

