import 'package:flutter/material.dart';
import 'package:seelabs/api.dart';
import 'package:seelabs/home.dart';
import 'package:seelabs/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SeeLabsAPI seeLabsAPI;
  final _unameController = TextEditingController();
  final _passController = TextEditingController();
  var uname = '';
  var pass = '';

  @override
  void initState() {
    super.initState();
    seeLabsAPI = SeeLabsAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Text('Laboran FTE'),
              ],
            ),
            SizedBox(
              height: 120.0,
            ),
            TextField(
              controller: _unameController,
              decoration: InputDecoration(filled: true, labelText: 'Username'),
              onChanged: (String value) => uname = value,
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _passController,
              decoration: InputDecoration(filled: true, labelText: 'Password'),
              onChanged: (String value) => pass = value,
              obscureText: true,
            ),
            SizedBox(
              height: 12.0,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    _unameController.clear();
                    _passController.clear();
                  },
                ),
                FlatButton(
                  child: Text('Login'),
                  onPressed: () {
                    seeLabsAPI.reqLogin(uname, pass).then(
                      (value) {
                        if (value == null) {
                          _failDialog(context);
                        } else {
                          pid = value.elementAt(0).pid;
                          aid=value.elementAt(0).aid;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                title: "Seelabs",
                              ),
                            ),
                          );
//                          Navigator.pop(context);
                        }
                      },
                    );
                    // if(seeLabsAPI.reqLogin(uname, pass) != null){
                    //   Navigator.pop(context);
                    // }
                    // else{
                    //   print("login fail");//Center(child: Text("Login Failed"));
                    // }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _failDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Login Failed"),
        content: new Text("No matching NIM and Password"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
