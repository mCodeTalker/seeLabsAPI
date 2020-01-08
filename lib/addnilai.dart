import 'package:flutter/material.dart';
import 'package:seelabs/api.dart';
import 'package:seelabs/anggota.dart';
import 'dart:async';
import 'package:seelabs/main.dart';

class AddNilaiPage extends StatefulWidget {
  AddNilaiPage({Key key, this.title, this.user}) : super(key: key);
  final String title;
  final Anggota user;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _AddNilaiPageState createState() => _AddNilaiPageState(title, user);
}

class _AddNilaiPageState extends State<AddNilaiPage> {
  String title;
  Anggota user;
  final _k1Controller = TextEditingController();
  final _k2Controller = TextEditingController();
  final _k3Controller = TextEditingController();
  int k1, k2, k3;
  SeeLabsAPI seeLabsAPI;
  _AddNilaiPageState(String title, Anggota user) {
    this.title = title;
    this.user = user;
    seeLabsAPI=SeeLabsAPI();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   anggota = seeLabsAPI.reqANilai(kid);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(user.fn, style: TextStyle(fontSize: 20)),
                )
              ],
            ),
          ),
          TextField(
            controller: _k1Controller,
            decoration: InputDecoration(filled: true, labelText: 'K1'),
            onChanged: (String value) => k1 = int.parse(value),
          ),
          TextField(
            controller: _k2Controller,
            decoration: InputDecoration(filled: true, labelText: 'K2'),
            onChanged: (String value) => k2 = int.parse(value),
          ),
          TextField(
            controller: _k3Controller,
            decoration: InputDecoration(filled: true, labelText: 'K3'),
            onChanged: (String value) => k3 = int.parse(value),
          ),
          RaisedButton(
            child: Center(
              child: Text("Update"),
            ),
            onPressed: () {
              setState(() {
                return FutureBuilder(
                  future: seeLabsAPI.updateNilai(user.uid, k1, k2, k3),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError) {
                          Text(
                            "Something wrong with message: ${snapshot.error.toString()}",
                          );
                        } else {
                          return AlertDialog(
                            title: new Text("Update Nilai"),
                            content: new Text("Berhasil"),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                    }
                  },
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
