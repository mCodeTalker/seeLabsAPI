import 'package:flutter/material.dart';
import 'package:seelabs/api.dart';
import 'package:seelabs/anggota.dart';
import 'package:seelabs/main.dart';

class AbsenPage extends StatefulWidget {
  AbsenPage({Key key, this.title, this.kid}) : super(key: key);
  final String title;
  final int kid;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _AbsenPageState createState() => _AbsenPageState(title, kid);
}

class _AbsenPageState extends State<AbsenPage> {
  String title;
  int kid;
  List<bool> present;
  Future<List<Anggota>> anggota;
  SeeLabsAPI seeLabsAPI = SeeLabsAPI();

  _AbsenPageState(String title, int kid) {
    this.title = title;
    this.kid = kid;
  }

  @override
  void initState() {
    super.initState();
    anggota = seeLabsAPI.reqAnggota(kid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: FutureBuilder(
          future: anggota,
          builder:
              (BuildContext context, AsyncSnapshot<List<Anggota>> snapshot) {
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
                  return Column(
                    children: snapshot.data
                        .map((user) => GestureDetector(
                              child: CheckboxListTile(
                                title: Text(user.fn),
                                value: user.presensi,
                                // onChanged: (bool value){

                                // },
                              ),
                              onTap: () {
                                setState(() {
                                  user.presensi = !user.presensi;
                                  if (user.presensi == true) {
                                    return new FutureBuilder(
                                      future: seeLabsAPI.editAbsen(
                                          kid, user.uid, modul, 1),
                                      builder: (BuildContext con,
                                          AsyncSnapshot<bool> snap) {
                                        switch (snap.connectionState) {
                                          case ConnectionState.waiting:
                                            print(snap.connectionState);
                                            return new CircularProgressIndicator();
                                          default:
                                            print("error");
                                            return AlertDialog(
                                              title: Text("Absen"),
                                              content:
                                                  Text("Add Present Success"),
                                            );
                                        }
                                      },
                                    );
                                  } else {
                                    return new FutureBuilder(
                                      future: seeLabsAPI.editAbsen(
                                          kid, user.uid, modul, 0),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<bool> snap) {
                                        switch (snap.connectionState) {
                                          case ConnectionState.waiting:
                                            return new CircularProgressIndicator();
                                          default:
                                            return AlertDialog(
                                              title: Text("Absen"),
                                              content:
                                                  Text("Add Present Success"),
                                            );
                                        }
                                      },
                                    );
                                  }
                                }); // print();
                              },
                            ))
                        .toList(),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
