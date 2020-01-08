import 'package:flutter/material.dart';
import 'package:seelabs/api.dart';
import 'package:seelabs/kelompok.dart';
import 'package:seelabs/absen.dart';
import 'package:seelabs/main.dart';
import 'package:seelabs/nilai.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _MyHomePageState createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> {
  String title;
  int dropDownHari;
  int dropDownModul;
  List<String> listHari = ['Senin (mgg1)', 'Selasa (mgg1)', 'Rabu (mgg1)'];
  List<int> listModul = [1, 2, 3, 4, 5, 6, 7, 8];
  int _selectedIndex;
  SeeLabsAPI seeLabsAPI = SeeLabsAPI();

  _MyHomePageState(String title) {
    this.title = title;
  }
  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    dropDownHari = 0;
    dropDownModul = 1;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hari == 0 || modul == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              DropdownButton<int>(
                value: dropDownHari,
                onChanged: (int newval) {
                  setState(() {
                    dropDownHari = newval;
                    hari = dropDownHari + 1;
                  });
                },
                items: listHari.map<DropdownMenuItem<int>>((String value) {
                  return DropdownMenuItem<int>(
                    value: listHari.indexOf(value),
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<int>(
                value: dropDownModul,
                onChanged: (int newval) {
                  setState(() {
                    dropDownModul = newval;
                    modul = dropDownModul;
                  });
                },
                items: listModul.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    } else {
      if (_selectedIndex == 0) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            leading: BackButton(
              onPressed: () {
                setState(() {
                  hari = 0;
                  modul = 0;
                });
              },
            ),
          ),
          body: Center(
            child: FutureBuilder(
              future: seeLabsAPI.reqKelompok(hari),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Kelompok>> snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    "Something wrong with message: ${snapshot.error.toString()}",
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<Kelompok> groups = snapshot.data;
                  return _buildListView(groups, "absen");
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Absen'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                title: Text('Nilai'),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: BackButton(
              onPressed: () {
                setState(() {
                  hari = 0;
                  modul = 0;
                });
              },
            ),
          ),
          body: Center(
            child: FutureBuilder(
              future: seeLabsAPI.reqNilai(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Kelompok>> snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    "Something wrong with message: ${snapshot.error.toString()}",
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<Kelompok> groups = snapshot.data;
                  return _buildListView(groups, "nilai");
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Absen'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                title: Text('Nilai'),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        );
      }
    }
  }
}

Widget _buildListView(List<Kelompok> groups, String page) {
  switch (page) {
    case "absen":
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            int id = groups.elementAt(index).id;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AbsenPage(
                      title: "Absen Praktikum",
                      kid: id,
                    ),
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "$id",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
            );
          },
        ),
      );
    case "nilai":
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            int id = groups.elementAt(index).id;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NilaiPage(
                      title: "Nilai Praktikum",
                      kid: id,
                    ),
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "$id",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
            );
          },
        ),
      );
  }
}
