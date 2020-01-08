import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'users.dart';

class Seelabs extends StatelessWidget {
  final Future<List<User>> users;
  Seelabs({Key key, this.users}): super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laboran FTE',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
           // initialRoute: '/login',
      // onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext) => LoginPage(),
        fullscreenDialog: true);
  }
}
